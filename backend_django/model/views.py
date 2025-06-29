# /backend_django/model/views.py

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST # 1. Impor decorator baru
from django.apps import apps
import json

@csrf_exempt
@require_POST
def sensor_api_view(request):
    model = apps.get_app_config('model').model_instance
    if not model:
        return JsonResponse({'error': 'Layanan tidak tersedia, model AI sedang tidak aktif.'}, status=503)

    try:
        if not request.body:
            return JsonResponse({'error': 'Body permintaan tidak boleh kosong.'}, status=400)
            
        data = json.loads(request.body)
        
        if not isinstance(data, dict):
            return JsonResponse({'error': 'Format body harus berupa objek JSON.'}, status=400)
            
        judul = data.get('judul')
        deskripsi = data.get('deskripsi')

        if judul is None:
            return JsonResponse({'error': 'Field "judul" wajib ada di dalam body JSON.'}, status=400)
        if not isinstance(judul, str):
            return JsonResponse({'error': 'Nilai dari field "judul" harus berupa string.'}, status=400)
        if not judul.strip():
            return JsonResponse({'error': 'Nilai dari field "judul" tidak boleh kosong atau hanya berisi spasi.'}, status=400)

        if deskripsi is None:
            return JsonResponse({'error': 'Field "deskripsi" wajib ada di dalam body JSON.'}, status=400)
        if not isinstance(deskripsi, str):
            return JsonResponse({'error': 'Nilai dari field "deskripsi" harus berupa string.'}, status=400)
        if not deskripsi.strip():
            return JsonResponse({'error': 'Nilai dari field "deskripsi" tidak boleh kosong atau hanya berisi spasi.'}, status=400)
            
    except json.JSONDecodeError:
        return JsonResponse({'error': 'Format JSON tidak valid.'}, status=400)

    try:
        resultjudul = model.predict(judul)
        resultdeskripsi = model.predict(deskripsi)
        return JsonResponse({
            'judul': resultjudul,
            'deskripsi': resultdeskripsi
        })
    except Exception as e:
        print(f"ERROR saat menjalankan model.predict(): {e}")
        return JsonResponse({'error': 'Terjadi kesalahan internal saat memproses teks.'}, status=500)
