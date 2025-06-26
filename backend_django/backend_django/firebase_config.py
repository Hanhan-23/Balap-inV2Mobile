import firebase_admin 
from firebase_admin import credentials

import os
from django.conf import settings

# Gunakan absolute path jika file di luar BASE_DIR
cred_path = os.path.join(settings.BASE_DIR, 'serviceAccountKey.json')

if not firebase_admin._apps:
    cred = credentials.Certificate(cred_path)
    firebase_admin.initialize_app(cred)