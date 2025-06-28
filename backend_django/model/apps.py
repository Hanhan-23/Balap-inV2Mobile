# /backend_django/model/apps.py (Versi Definitif Final)

from django.apps import AppConfig
from django.conf import settings
import torch
import os
import sys

# Impor modul yang berisi definisi kelas kita
from . import custom_model_classes

class ModelConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'model'
    model_instance = None

    def ready(self):
        # Filter proses Celery (sudah bekerja dengan baik)
        is_celery_process = any('celery' in arg for arg in sys.argv)
        if is_celery_process:
            print(">>> [Info Celery] Proses Celery terdeteksi, pemuatan model AI dilewati.")
            return

        # Muat model jika ini bukan proses Celery
        if not self.model_instance:
            print(">>> [Info Web Server] Memulai proses pemuatan model AI portabel...")

            # ====================================================================
            # --- SOLUSI FINAL UNTUK ERROR 'No module named ...' ---
            # ====================================================================
            # Baris ini secara manual memberitahu Python: 
            # "Jika ada yang mencari modul bernama 'custom_model_classes', 
            # berikan saja modul yang sebenarnya, yaitu 'backend_django.model.custom_model_classes'
            # yang sudah kita impor di atas."
            # Ini "menipu" torch.load agar menemukan definisi kelas yang benar.
            sys.modules['custom_model_classes'] = custom_model_classes
            # ====================================================================

            # Pastikan nama file di sini sesuai dengan yang baru Anda simpan (v2)
            model_path = os.path.join(settings.BASE_DIR, 'model', 'model_files', 'integrated_abusive_classifier_v2.pth')
            print(f">>> Path model yang dituju: {model_path}")
            
            try:
                device = torch.device('cpu')
                # Sekarang torch.load akan berhasil
                self.model_instance = torch.load(model_path, map_location=device, weights_only=False)
                self.model_instance.eval()
                print(">>> Model AI Portabel Berhasil Dimuat ke Memori.")

            except Exception as e:
                print(f">>> KRITIS: Gagal total memuat model karena error: {e}")