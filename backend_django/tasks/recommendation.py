import numpy as np
import pandas as pd
from pymongo import MongoClient
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
from firebase_admin import messaging
from bson import ObjectId
from datetime import datetime
from decouple import config

def recommendations():
    # MongoDB connection
    client = MongoClient(config('MONGO_HOST'))
    db = client['balap_in']
    
    # Collections
    laporan_collection = db['laporan']
    rekomendasi_collection = db['rekomendasi']
    notifikasi_collection = db['notifikasi']
    
    try:
        # Step 1: Get laporan IDs that are assigned to completed recommendations
        completed_recommendations = rekomendasi_collection.find({
            'status_rekom': 'selesai'
        })
        
        excluded_laporan_ids = []
        for rekom in completed_recommendations:
            excluded_laporan_ids.extend(rekom.get('id_laporan', []))
        
        # Convert to ObjectId if they're strings
        excluded_laporan_ids = [ObjectId(id_) if isinstance(id_, str) else id_ for id_ in excluded_laporan_ids]
        
        # Step 2: Get all laporan except those in completed recommendations
        query_filter = {
            'status': 'selesai',
            '_id': {'$nin': excluded_laporan_ids}
        }
        
        available_laporan = list(laporan_collection.find(query_filter))
        
        if not available_laporan:
            print("No available laporan for recommendation")
            return
        
        # Step 3: Group by cluster and calculate aggregated data
        cluster_data = {}
        
        for laporan in available_laporan:
            cluster = laporan['cluster']
            
            if cluster not in cluster_data:
                cluster_data[cluster] = {
                    'laporan_ids': [],
                    'jenis_list': [],
                    'cuaca_list': [],
                    'persentase_list': [],
                    'lokasi': laporan['id_peta']['jalan']  # Get location from first report
                }
            
            cluster_data[cluster]['laporan_ids'].append(str(laporan['_id']))
            cluster_data[cluster]['jenis_list'].append(laporan['jenis'])
            cluster_data[cluster]['cuaca_list'].append(laporan['cuaca'])
            cluster_data[cluster]['persentase_list'].append(laporan['persentase'])
        
        # Prepare data for TOPSIS
        topsis_data = []
        
        for cluster, data in cluster_data.items():
            # Calculate dominant values
            jenis_counts = pd.Series(data['jenis_list']).value_counts()
            cuaca_counts = pd.Series(data['cuaca_list']).value_counts()
            
            dominant_jenis = jenis_counts.index[0]
            dominant_cuaca = cuaca_counts.index[0]
            avg_persentase = np.mean(data['persentase_list'])
            num_reports = len(data['laporan_ids'])
            
            topsis_data.append({
                'cluster': cluster,
                'NumReports': num_reports,
                'jenis': dominant_jenis,
                'cuaca': dominant_cuaca,
                'persentase': avg_persentase,
                'laporan_ids': data['laporan_ids'],
                'lokasi': data['lokasi']
            })
        
        # Convert to DataFrame
        df = pd.DataFrame(topsis_data)
        
        # Conversion functions
        def persentaseconvert(value):
            convertmap = {
                1.0: 6, 0.8: 5, 0.6: 4, 0.4: 3, 0.2: 2, 0.0: 1
            }
            # Find closest match
            closest_key = min(convertmap.keys(), key=lambda x: abs(x - value))
            return convertmap[closest_key]
        
        def jenisconvert(value):
            convertmap = {
                'jalan': 3, 'jembatan': 2, 'lampu_jalan': 1
            }
            return convertmap.get(value, 1)
        
        def cuacaconvert(value):
            convertmap = {
                'hujan': 2, 'cerah': 1
            }
            return convertmap.get(value, 1)
        
        # Apply conversions
        df['Percentage'] = df['persentase'].apply(persentaseconvert)
        df['InfrastructureType'] = df['jenis'].apply(jenisconvert)
        df['WeatherImpact'] = df['cuaca'].apply(cuacaconvert)
        
        # TOPSIS Algorithm
        # Define weights for each criterion
        weights = np.array([0.35, 0.3, 0.2, 0.15])
        
        # Step 1: Normalize the decision matrix
        decision_matrix = df[['NumReports', 'InfrastructureType', 'WeatherImpact', 'Percentage']].values
        denominator = np.sqrt(np.sum(decision_matrix**2, axis=0))
        normalized_matrix = decision_matrix / denominator
        
        # Step 2: Multiply by weights
        weighted_matrix = normalized_matrix * weights
        
        # Step 3: Identify ideal and anti-ideal solutions
        ideal_solution = np.max(weighted_matrix, axis=0)
        anti_ideal_solution = np.min(weighted_matrix, axis=0)
        
        # Step 4: Calculate distance to ideal and anti-ideal solutions
        distance_to_ideal = np.sqrt(np.sum((weighted_matrix - ideal_solution)**2, axis=1))
        distance_to_anti_ideal = np.sqrt(np.sum((weighted_matrix - anti_ideal_solution)**2, axis=1))
        
        # Step 5: Calculate similarity to ideal solution (TOPSIS score)
        if len(df) == 1:
            topsis_score = np.array([1.0])
        else:
            topsis_score = distance_to_anti_ideal / (distance_to_ideal + distance_to_anti_ideal)
        
        # Handle duplicate scores
        temp_df = pd.DataFrame({'original_score': topsis_score})
        temp_df['adjusted_score'] = temp_df['original_score'].copy()
        
        for score in temp_df['original_score'].unique():
            mask = temp_df['original_score'] == score
            count = mask.sum()
            
            if count > 1:
                indices = temp_df[mask].index
                for i, idx in enumerate(indices):
                    temp_df.loc[idx, 'adjusted_score'] = score + (i * 0.00000001)
        
        topsis_score = temp_df['adjusted_score'].values
        
        # Step 6: Assign priority
        priority_labels = ["tinggi", "sedang", "rendah"]
        if len(df) == 1:
            # Cold start problem - first recommendation gets high priority
            df['Priority'] = priority_labels[0]
        else:
            df['Priority'] = pd.qcut(topsis_score, q=3, labels=priority_labels[::-1])
        
        df['TOPSIS_Score'] = topsis_score
        
        # Step 7: Update or insert recommendations
        for _, row in df.iterrows():
            cluster = row['cluster']
            
            # Check if recommendation already exists for this cluster
            existing_rekom = rekomendasi_collection.find_one({
                'id_laporan': {'$in': row['laporan_ids']}
            })
            
            if existing_rekom:
                # Update existing recommendation
                previous_status = existing_rekom.get('status_urgent')
                
                # Update the existing recommendation
                update_data = {
                    'jumlah_laporan': row['NumReports'],
                    'status_urgent': row['Priority'],
                    'tingkat_urgent': float(row['TOPSIS_Score']),
                    'id_laporan': list(set(existing_rekom.get('id_laporan', []) + row['laporan_ids']))
                }
                
                rekomendasi_collection.update_one(
                    {'_id': existing_rekom['_id']},
                    {'$set': update_data}
                )
                
                rekomendasi_id = existing_rekom['_id']
                
            else:
                # Insert new recommendation
                new_rekom = {
                    'jumlah_laporan': row['NumReports'],
                    'status_urgent': row['Priority'],
                    'tingkat_urgent': float(row['TOPSIS_Score']),
                    'status_rekom': 'valid',
                    'tgl_rekom': datetime.now(),
                    'id_laporan': row['laporan_ids']
                }
                
                result = rekomendasi_collection.insert_one(new_rekom)
                rekomendasi_id = result.inserted_id
                previous_status = None
            
            # Check if notification should be sent
            if (previous_status in ["sedang", "rendah"]) and row['Priority'] == "tinggi":
                notification_message = f"Prioritas {row['lokasi']} dari {previous_status} Menjadi Tinggi!"
                
                # Insert notification
                notification_doc = {
                    'id_rekomendasi': rekomendasi_id,
                    'pesan': notification_message,
                    'tgl_notif': datetime.now()
                }
                
                notif_result = notifikasi_collection.insert_one(notification_doc)
                
                if notif_result.inserted_id:
                    try:
                        # Send WebSocket notification
                        channel_layer = get_channel_layer()
                        async_to_sync(channel_layer.group_send)(
                            "notifications",
                            {
                                "type": "send_notification",
                                "message": notification_message,
                            }
                        )
                        print("WebSocket notification sent successfully.")
                        
                        # Send FCM notification
                        fcm_message = messaging.Message(
                            notification=messaging.Notification(
                                title="Menjadi Sorotan Masyarakat Batam!",
                                body=notification_message
                            ),
                            topic="global_notifications"
                        )
                        
                        response = messaging.send(fcm_message)
                        print(f"FCM notification sent successfully: {response}")
                        
                    except Exception as ws_error:
                        print(f"Kesalahan WebSocket: {ws_error}")
        
        # Print final results
        final_df = df[['cluster', 'NumReports', 'Priority', 'TOPSIS_Score']]
        print("Final TOPSIS Results:")
        print(final_df)
        
    except Exception as e:
        print(f"Terjadi kesalahan: {e}")
    
    finally:
        client.close()


@api_view(['POST'])
def run_recommendations(request):
    """
    API endpoint to run the TOPSIS recommendation algorithm
    """
    try:
        recommendations()
        return Response({
            'status': 'success',
            'message': 'Recommendations processed successfully'
        }, status=status.HTTP_200_OK)
    
    except Exception as e:
        return Response({
            'status': 'error',
            'message': str(e)
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)