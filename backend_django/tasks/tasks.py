from celery import shared_task
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer
import pandas as pd
from sklearn.cluster import DBSCAN
from geopy.distance import geodesic
from pymongo import MongoClient, UpdateOne
from .recommendation import recommendations

@shared_task
def hello_celery():
    print("Hello from Celery")

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
    client = MongoClient('mongodb://localhost:27017/')
    db = client['balap_in']

    pipeline = [
        {
            '$match': {'status': 'selesai'}
        },
        {
            '$lookup': {
                'from': 'peta',
                'localField': 'id_laporan',
                'foreignField': 'id_laporan_id',
                'as': 'peta_info'
            }
        },
        {
            '$unwind': '$peta_info'
        },
        {
            '$project': {
                'id_laporan': 1,
                'jenis': 1,
                'latitude': '$peta_info.latitude',
                'longitude': '$peta_info.longitude'
            }
        }
    ]

    result = list(db.laporan.aggregate(pipeline))

    if not result:
        print("Tidak ada data yang bisa diklaster.")
        return

    df = pd.DataFrame(result)

    df['cluster'] = -1

    def haversine_distance(coord1, coord2):
        return geodesic(coord1, coord2).meters

    result = []
    start_cluster_index = 0 

    for jenis, group in df.groupby('jenis'):
        print(f"Clustering untuk jenis: {jenis}")

        coordinates = group[['latitude', 'longitude']].to_numpy()

        dbscan = DBSCAN(eps=200, min_samples=1, metric=lambda x, y: haversine_distance(x, y))
        clusters = dbscan.fit_predict(coordinates)

        clusters += start_cluster_index
        group['cluster'] = clusters

        start_cluster_index = clusters.max() + 1

        result.append(group)

    final_df = pd.concat(result)

    print(final_df)

    bulk_updates = []
    for _, row in final_df.iterrows():
        bulk_updates.append(
            UpdateOne(
                {'id_laporan': row['id_laporan']},
                {'$set': {'cluster': int(row['cluster'])}}
            )
        )

    if bulk_updates:
        db.laporan.bulk_write(bulk_updates)
        print("Hasil clustering telah disimpan ke MongoDB.")
        recommendations()
    else:
        print("Tidak ada data yang perlu di-update.")

    client.close()