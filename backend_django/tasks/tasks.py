from celery import shared_task
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
import pandas as pd
from sklearn.cluster import DBSCAN
from geopy.distance import geodesic
from pymongo import MongoClient, UpdateOne
from .recommendation import recommendations
from decouple import config
import numpy as np
from bson import ObjectId

@shared_task
def hello_celery():
    clustering()

    channel_layer = get_channel_layer()
    async_to_sync(channel_layer.group_send)(
        'countdown_group',
        {
            'type': 'send_countdown',
            'message': 'reset' 
        }
    )


@shared_task
def clustering():
    # Koneksi ke MongoDB
    client = MongoClient(config('MONGO_HOST'))
    db = client['balap_in']
    laporan_collection = db['laporan']
    rekomendasi_collection = db['rekomendasi']
   
    try:
        print("=== MEMULAI PROSES CLUSTERING ===")
        
        # Langkah 1: Ambil semua ID laporan yang sudah ada di rekomendasi dengan status_rekom = "selesai"
        # PERBAIKAN: Menggunakan field 'id_laporan' yang benar
        pipeline_selesai = [
            {"$match": {"status_rekom": "selesai"}},
            {"$unwind": "$id_laporan"},  # Unwind field 'id_laporan'
            {"$group": {"_id": None, "id_laporan_selesai": {"$addToSet": "$id_laporan"}}}  # Kumpulkan dari field 'id_laporan'
        ]
       
        result_selesai = list(rekomendasi_collection.aggregate(pipeline_selesai))
        id_laporan_selesai = result_selesai[0]['id_laporan_selesai'] if result_selesai else []
        
        # PERBAIKAN: Convert string ID ke ObjectId untuk MongoDB query
        id_laporan_selesai_objectid = []
        for id_str in id_laporan_selesai:
            try:
                if isinstance(id_str, str):
                    id_laporan_selesai_objectid.append(ObjectId(id_str))
                else:
                    id_laporan_selesai_objectid.append(id_str)  # Sudah ObjectId
            except Exception as e:
                print(f"Warning: ID tidak valid {id_str}: {e}")
       
        print(f"Jumlah laporan dengan status_rekom selesai: {len(id_laporan_selesai_objectid)}")
        if id_laporan_selesai_objectid:
            print(f"Sample ID laporan selesai: {id_laporan_selesai_objectid[:3]}")
       
        # Langkah 2: Tentukan cluster_id_start berdasarkan cluster tertinggi yang sudah ada
        # dari laporan yang memiliki status_rekom = "selesai"
        max_cluster_existing = 0
        if id_laporan_selesai_objectid:
            existing_clusters = laporan_collection.find(
                {"_id": {"$in": id_laporan_selesai_objectid}, "cluster": {"$ne": None}},
                {"cluster": 1}
            )
            clusters_list = [doc['cluster'] for doc in existing_clusters if doc.get('cluster') is not None]
            if clusters_list:
                max_cluster_existing = max(clusters_list)
        
        print(f"Cluster tertinggi yang sudah ada: {max_cluster_existing}")
       
        # Langkah 3: Query untuk mendapatkan laporan yang akan di-clustering
        # PERBAIKAN: Exclude laporan yang sudah ada di rekomendasi dengan status_rekom selesai
        query_filter = {
            "_id": {"$nin": id_laporan_selesai_objectid},  # Tidak termasuk laporan dengan status_rekom selesai
            "id_peta.latitude": {"$exists": True, "$ne": None}, # Memastikan ada koordinat latitude
            "id_peta.longitude": {"$exists": True, "$ne": None}  # Memastikan ada koordinat longitude
        }
       
        # Debug: Cek berapa laporan yang akan di-exclude
        total_laporan_semua = laporan_collection.count_documents({
            "id_peta.latitude": {"$exists": True, "$ne": None},
            "id_peta.longitude": {"$exists": True, "$ne": None}
        })
        print(f"Total laporan dengan koordinat: {total_laporan_semua}")
       
        # Ambil data laporan yang akan di-clustering
        laporan_cursor = laporan_collection.find(query_filter)
        laporan_data = []
       
        for doc in laporan_cursor:
            # PERBAIKAN: Validasi koordinat untuk memastikan tidak null/invalid
            lat = doc['id_peta'].get('latitude')
            lng = doc['id_peta'].get('longitude')
            
            if lat is not None and lng is not None and isinstance(lat, (int, float)) and isinstance(lng, (int, float)):
                laporan_data.append({
                    'id_laporan': str(doc['_id']),  # Convert ObjectId to string untuk consistency
                    'jenis': doc['jenis'],
                    'latitude': float(lat),
                    'longitude': float(lng),
                    'cluster_lama': doc.get('cluster', None)
                })
       
        if not laporan_data:
            print("Tidak ada laporan yang perlu di-clustering")
            return
       
        df = pd.DataFrame(laporan_data)
        print(f"Jumlah laporan yang akan di-clustering: {len(df)}")
        print(f"Laporan yang di-exclude (status_rekom selesai): {len(id_laporan_selesai_objectid)}")
       
        # Tampilkan breakdown per jenis
        print("\nBreakdown per jenis:")
        for jenis in df['jenis'].unique():
            total_jenis = len(df[df['jenis'] == jenis])
            print(f"  {jenis}: {total_jenis} laporan")
       
        # Inisialisasi kolom cluster untuk data baru
        df['cluster'] = -1
       
        # Fungsi untuk menghitung jarak geodesic
        def haversine_distance(coord1, coord2):
            try:
                return geodesic(coord1, coord2).meters
            except Exception as e:
                print(f"Error calculating distance: {e}")
                return float('inf')  # Return infinite distance jika error
       
        # Proses clustering per jenis (memastikan jenis berbeda tidak bisa satu cluster)
        result = []
        start_cluster_index = max_cluster_existing + 1  # Mulai dari cluster ID setelah yang sudah ada
       
        print(f"Memulai clustering dengan cluster ID dari: {start_cluster_index}")
        print(f"Jenis laporan yang akan di-clustering: {df['jenis'].unique()}")
       
        for jenis, group in df.groupby('jenis'):
            print(f"\n=== Clustering untuk jenis: {jenis} ===")
            print(f"Jumlah laporan jenis {jenis}: {len(group)}")
           
            if len(group) == 0:
                continue
                
            # Ambil koordinat dari grup
            coordinates = group[['latitude', 'longitude']].to_numpy()
           
            # PERBAIKAN: Parameter clustering yang lebih optimal per jenis
            if jenis == 'lampu_jalan':
                eps_value = 200  # Jarak 200m untuk lampu jalan
                min_samples_value = 1
            elif jenis == 'jalan_rusak' or jenis == 'jalan':
                eps_value = 150  # Jarak 150m untuk jalan rusak/jalan
                min_samples_value = 2
            elif jenis == 'jembatan':
                eps_value = 300  # Jarak 300m untuk jembatan (biasanya lebih jarang)
                min_samples_value = 1
            else:
                # Parameter default untuk jenis lainnya
                eps_value = 200
                min_samples_value = 1
           
            print(f"Parameter clustering - eps: {eps_value}m, min_samples: {min_samples_value}")
           
            # PERBAIKAN: Handling untuk kasus hanya 1 data point
            if len(coordinates) == 1:
                clusters = np.array([start_cluster_index])
                print(f"Hanya 1 data point, langsung assign ke cluster {start_cluster_index}")
                start_cluster_index += 1
            else:
                # DBSCAN clustering
                db_scan = DBSCAN(
                    eps=eps_value, 
                    min_samples=min_samples_value,
                    metric=lambda x, y: haversine_distance(x, y)
                )
                clusters = db_scan.fit_predict(coordinates)
           
                # Ganti cluster -1 (noise) dengan cluster baru
                unique_clusters = np.unique(clusters)
                cluster_mapping = {}
           
                print(f"Hasil clustering DBSCAN: {unique_clusters}")
           
                for cluster_id in unique_clusters:
                    if cluster_id == -1:
                        # Untuk noise, beri cluster individual
                        noise_indices = np.where(clusters == -1)[0]
                        print(f"Memberikan cluster individual untuk {len(noise_indices)} noise points")
                        for idx in noise_indices:
                            clusters[idx] = start_cluster_index
                            print(f"  Noise point index {idx} -> cluster {start_cluster_index}")
                            start_cluster_index += 1
                    else:
                        cluster_mapping[cluster_id] = start_cluster_index
                        count_in_cluster = np.sum(clusters == cluster_id)
                        print(f"  Cluster {cluster_id} ({count_in_cluster} points) -> cluster {start_cluster_index}")
                        start_cluster_index += 1
           
                # Terapkan mapping untuk cluster yang bukan noise
                for i, cluster_id in enumerate(clusters):
                    if cluster_id in cluster_mapping:
                        clusters[i] = cluster_mapping[cluster_id]
           
            # Assign cluster results ke group
            group_copy = group.copy()
            group_copy['cluster'] = clusters
           
            # Validasi: pastikan dalam satu cluster hanya ada satu jenis
            cluster_validation = group_copy.groupby('cluster')['jenis'].nunique()
            invalid_clusters = cluster_validation[cluster_validation > 1]
           
            if len(invalid_clusters) > 0:
                print(f"WARNING: Ditemukan cluster dengan lebih dari 1 jenis: {invalid_clusters.to_dict()}")
            else:
                print(f"Validasi berhasil: Setiap cluster hanya memiliki 1 jenis")
           
            result.append(group_copy)
            print(f"Selesai clustering jenis {jenis}. Next cluster ID: {start_cluster_index}")
       
        # Gabungkan hasil clustering
        final_df = pd.concat(result, ignore_index=True)
       
        # Validasi final: pastikan tidak ada cluster yang memiliki jenis berbeda
        print(f"\n=== VALIDASI FINAL ===")
        final_validation = final_df.groupby('cluster').agg({
            'jenis': ['nunique', 'first'],
            'id_laporan': 'count'
        }).round(2)
        final_validation.columns = ['jumlah_jenis', 'jenis', 'jumlah_laporan']
       
        print("Ringkasan cluster:")
        print(final_validation.to_string())
       
        # Cek apakah ada cluster dengan lebih dari 1 jenis
        mixed_clusters = final_validation[final_validation['jumlah_jenis'] > 1]
        if len(mixed_clusters) > 0:
            print(f"\nERROR: Ditemukan {len(mixed_clusters)} cluster dengan jenis campuran!")
            print(mixed_clusters.to_string())
            return
        else:
            print(f"VALIDASI BERHASIL: Semua cluster hanya memiliki 1 jenis")
       
        print(f"\nHasil clustering detail:")
        detail_output = final_df[['id_laporan', 'jenis', 'latitude', 'longitude', 'cluster']].copy()
        print(detail_output.to_string())
       
        # Langkah 4: Update hasil clustering ke database
        print(f"\n=== UPDATE DATABASE ===")
        bulk_operations = []
        for _, row in final_df.iterrows():
            bulk_operations.append(
                UpdateOne(
                    {"_id": ObjectId(row['id_laporan'])},
                    {"$set": {"cluster": int(row['cluster'])}}
                )
            )
       
        if bulk_operations:
            result_update = laporan_collection.bulk_write(bulk_operations)
            print(f"Berhasil update {result_update.modified_count} dokumen")
           
            # Verifikasi update dengan menampilkan beberapa contoh
            sample_check = laporan_collection.find(
                {"_id": {"$in": [ObjectId(row['id_laporan']) for _, row in final_df.head(3).iterrows()]}},
                {"_id": 1, "jenis": 1, "cluster": 1}
            )
            print("Verifikasi update (sample):")
            for doc in sample_check:
                print(f"  ID: {doc['_id']}, Jenis: {doc['jenis']}, Cluster: {doc.get('cluster', 'None')}")
        else:
            print("Tidak ada data untuk diupdate")
       
        print("Clustering selesai!")
        recommendations()
       
    except Exception as e:
        print(f"Terjadi kesalahan: {e}")
        import traceback
        traceback.print_exc()
    finally:
        client.close()

def check_clustering_status():
    """Fungsi helper untuk melihat status clustering"""
    client = MongoClient(config('MONGO_HOST'))
    db = client['balap_in']
    laporan_collection = db['laporan']
    rekomendasi_collection = db['rekomendasi']
   
    try:
        print("=== STATUS CLUSTERING ===")
        
        # PERBAIKAN: Cek laporan dengan status_rekom selesai menggunakan field 'id_laporan'
        pipeline_selesai = [
            {"$match": {"status_rekom": "selesai"}},
            {"$unwind": "$id_laporan"},
            {"$group": {"_id": None, "id_laporan_selesai": {"$addToSet": "$id_laporan"}}}
        ]
       
        result_selesai = list(rekomendasi_collection.aggregate(pipeline_selesai))
        id_laporan_selesai = result_selesai[0]['id_laporan_selesai'] if result_selesai else []
        
        # Convert ke ObjectId
        id_laporan_selesai_objectid = []
        for id_str in id_laporan_selesai:
            try:
                if isinstance(id_str, str):
                    id_laporan_selesai_objectid.append(ObjectId(id_str))
                else:
                    id_laporan_selesai_objectid.append(id_str)
            except Exception as e:
                print(f"Warning: ID tidak valid {id_str}: {e}")
       
        print(f"Laporan dengan status_rekom selesai: {len(id_laporan_selesai_objectid)}")
       
        # Cek laporan yang akan di-clustering
        query_filter = {
            "_id": {"$nin": id_laporan_selesai_objectid},
            "id_peta.latitude": {"$exists": True, "$ne": None},
            "id_peta.longitude": {"$exists": True, "$ne": None}
        }
       
        count_to_cluster = laporan_collection.count_documents(query_filter)
        print(f"Laporan yang akan di-clustering: {count_to_cluster}")
       
        # Debug: Detail breakdown
        print(f"\nDetail breakdown:")
        total_dengan_koordinat = laporan_collection.count_documents({
            "id_peta.latitude": {"$exists": True, "$ne": None},
            "id_peta.longitude": {"$exists": True, "$ne": None}
        })
        print(f"  Total laporan dengan koordinat: {total_dengan_koordinat}")
        print(f"  Laporan di-exclude (status_rekom selesai): {len(id_laporan_selesai_objectid)}")
        print(f"  Laporan yang akan di-clustering: {count_to_cluster}")
       
        # Cek distribusi cluster saat ini
        pipeline_cluster = [
            {"$match": {"cluster": {"$ne": None, "$exists": True}}},
            {"$group": {"_id": "$cluster", "count": {"$sum": 1}, "jenis": {"$addToSet": "$jenis"}}},
            {"$sort": {"_id": 1}}
        ]
       
        cluster_distribution = list(laporan_collection.aggregate(pipeline_cluster))
        print(f"\nDistribusi cluster saat ini:")
        if cluster_distribution:
            for cluster in cluster_distribution:
                jenis_str = ", ".join(cluster['jenis'])
                print(f"  Cluster {cluster['_id']}: {cluster['count']} laporan ({jenis_str})")
        else:
            print("  Belum ada cluster yang terbentuk")
            
        # Cek laporan tanpa cluster
        count_no_cluster = laporan_collection.count_documents({
            "cluster": {"$in": [None, -1]}
        })
        print(f"Laporan tanpa cluster: {count_no_cluster}")
        
        # TAMBAHAN: Cek detail rekomendasi
        print(f"\n=== DETAIL REKOMENDASI ===")
        rekomendasi_pipeline = [
            {"$group": {"_id": "$status_rekom", "count": {"$sum": 1}, "total_laporan": {"$sum": {"$size": "$id_laporan"}}}},
            {"$sort": {"count": -1}}
        ]
        rekom_detail = list(rekomendasi_collection.aggregate(rekomendasi_pipeline))
        for item in rekom_detail:
            print(f"  Status '{item['_id']}': {item['count']} rekomendasi, {item['total_laporan']} laporan")
           
    except Exception as e:
        print(f"Terjadi kesalahan: {e}")
        import traceback
        traceback.print_exc()
    finally:
        client.close()

def debug_laporan():
    """Fungsi untuk debugging data laporan"""
    client = MongoClient(config('MONGO_HOST'))
    db = client['balap_in']
    laporan_collection = db['laporan']
    rekomendasi_collection = db['rekomendasi']
    
    try:
        print("=== DEBUG DATA LAPORAN ===")
        
        # Total laporan
        total_laporan = laporan_collection.count_documents({})
        print(f"Total laporan: {total_laporan}")
        
        # Laporan dengan koordinat
        with_coordinates = laporan_collection.count_documents({
            "id_peta.latitude": {"$exists": True, "$ne": None},
            "id_peta.longitude": {"$exists": True, "$ne": None}
        })
        print(f"Laporan dengan koordinat: {with_coordinates}")
        
        # Breakdown per status
        pipeline_status = [
            {"$group": {"_id": "$status", "count": {"$sum": 1}}},
            {"$sort": {"count": -1}}
        ]
        status_breakdown = list(laporan_collection.aggregate(pipeline_status))
        print(f"Breakdown per status:")
        for item in status_breakdown:
            print(f"  - {item['_id']}: {item['count']}")
        
        # Breakdown per jenis
        pipeline_jenis = [
            {"$group": {"_id": "$jenis", "count": {"$sum": 1}}},
            {"$sort": {"count": -1}}
        ]
        jenis_breakdown = list(laporan_collection.aggregate(pipeline_jenis))
        print(f"Breakdown per jenis:")
        for item in jenis_breakdown:
            print(f"  - {item['_id']}: {item['count']}")
            
        # Cek laporan di rekomendasi
        total_rekomendasi = rekomendasi_collection.count_documents({})
        print(f"Total rekomendasi: {total_rekomendasi}")
        
        if total_rekomendasi > 0:
            # Breakdown per status_rekom
            pipeline_rekom = [
                {"$group": {"_id": "$status_rekom", "count": {"$sum": 1}}},
                {"$sort": {"count": -1}}
            ]
            rekom_breakdown = list(rekomendasi_collection.aggregate(pipeline_rekom))
            print(f"Breakdown per status_rekom:")
            for item in rekom_breakdown:
                print(f"  - {item['_id']}: {item['count']}")
        
        # TAMBAHAN: Sample data rekomendasi untuk debug
        print(f"\nSample data rekomendasi:")
        sample_rekom = list(rekomendasi_collection.find({}).limit(2))
        for i, rekom in enumerate(sample_rekom, 1):
            print(f"  {i}. ID: {rekom['_id']}")
            print(f"     Status: {rekom.get('status_rekom', 'None')}")
            print(f"     ID Laporan: {rekom.get('id_laporan', [])}")
            print(f"     Jumlah laporan: {len(rekom.get('id_laporan', []))}")
        
        # Sample laporan untuk debug
        sample_laporan = list(laporan_collection.find({}).limit(3))
        print(f"\nSample laporan:")
        for i, lap in enumerate(sample_laporan, 1):
            print(f"  {i}. ID: {lap['_id']}")
            print(f"     Jenis: {lap['jenis']}")
            print(f"     Status: {lap['status']}")
            print(f"     Koordinat: {lap['id_peta'].get('latitude', 'None')}, {lap['id_peta'].get('longitude', 'None')}")
            print(f"     Cluster: {lap.get('cluster', 'None')}")
            
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        client.close()