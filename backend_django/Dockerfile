# Dockerfile

# Gunakan base image Python yang stabil
FROM python:3.13

# Set variabel environment untuk best practice Python di Docker
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Tetapkan direktori kerja utama di dalam kontainer
WORKDIR /app

# Upgrade pip dan install dependensi
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Salin seluruh proyek Anda ke direktori kerja /app
COPY . .

# --- SOLUSI UNTUK HARDCODED PATH DI DALAM MODEL ---
# Membuat struktur folder yang sama seperti di Google Colab
RUN mkdir -p /content/indonesian-abusive-and-hate-speech-twitter-text

# Menyalin file-file CSV ke lokasi yang diharapkan oleh model
# Perhatikan path sumbernya disesuaikan dengan struktur Anda
COPY ./model/model_files/indonesian-abusive-and-hate-speech-twitter-text/new_kamusalay.csv /content/indonesian-abusive-and-hate-speech-twitter-text/new_kamusalay.csv
COPY ./model/model_files/indonesian-abusive-and-hate-speech-twitter-text/abusive.csv /content/indonesian-abusive-and-hate-speech-twitter-text/abusive.csv
# ----------------------------------------------------

# Port yang akan diekspos oleh kontainer
EXPOSE 8000

# Kita tidak lagi menggunakan CMD di sini. Perintah akan didefinisikan di docker-compose.yml