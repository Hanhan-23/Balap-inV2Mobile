# /backend_django/model/views.py

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST # 1. Impor decorator baru
from django.apps import apps
import json

@csrf_exempt
@require_POST # 2. Gunakan decorator untuk memastikan hanya metode POST
def sensor_api_view(request):
    
    # 3. Cek model terlebih dahulu agar lebih efisien
    #    Jika model tidak ada, langsung gagal tanpa perlu memproses body request.
    model = apps.get_app_config('model').model_instance
    if not model:
        return JsonResponse({'error': 'Layanan tidak tersedia, model AI sedang tidak aktif.'}, status=503)

    # 4. Validasi input JSON dengan lebih detail
    try:
        # Jika body request kosong sama sekali
        if not request.body:
            return JsonResponse({'error': 'Body permintaan tidak boleh kosong.'}, status=400)
            
        data = json.loads(request.body)
        
        # Jika body bukan sebuah objek JSON
        if not isinstance(data, dict):
            return JsonResponse({'error': 'Format body harus berupa objek JSON.'}, status=400)
            
        raw_text = data.get('text')

        # Pengecekan yang lebih spesifik untuk field 'text'
        if raw_text is None:
            return JsonResponse({'error': 'Field "text" wajib ada di dalam body JSON.'}, status=400)
        if not isinstance(raw_text, str):
            return JsonResponse({'error': 'Nilai dari field "text" harus berupa string.'}, status=400)
        if not raw_text.strip():
            return JsonResponse({'error': 'Nilai dari field "text" tidak boleh kosong atau hanya berisi spasi.'}, status=400)
            
    except json.JSONDecodeError: # 5. Gunakan exception yang spesifik
        return JsonResponse({'error': 'Format JSON tidak valid.'}, status=400)

    # 6. Jalankan prediksi di dalam blok try-except terpisah
    #    Ini untuk menangani jika ada error dari dalam model itu sendiri.
    try:
        result = model.predict(raw_text)
        return JsonResponse(result)
    except Exception as e:
        # Mencatat error di log server untuk debugging
        print(f"ERROR saat menjalankan model.predict(): {e}")
        return JsonResponse({'error': 'Terjadi kesalahan internal saat memproses teks.'}, status=500)