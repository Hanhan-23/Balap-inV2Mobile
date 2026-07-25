# 🚧 BALAP-IN V2 Mobile

BALAP-IN (Batam Road Infrastructure Reporting System) is a mobile application that enables citizens to report road infrastructure issues in Batam City. The system consists of a Flutter mobile application, a Django REST API backend, and a Rust service for additional functionalities.

---

# Features

- 📱 Cross-platform mobile application built with Flutter
- 🗺 Google Maps integration
- 📍 Location-based road damage reporting
- 📷 Image upload support
- 🔔 Push notifications using Firebase Cloud Messaging (FCM)
- 🚀 RESTful API powered by Django
- ⚡ High-performance backend service built with Rust
- 🔄 Asynchronous task processing with Celery
- 🧠 Redis for background task management

---

# Project Structure

```text
Balap-inV2Mobile/
│
├── frontend/              # Flutter Mobile Application
│
├── backend_django/        # Django REST API Backend
│
├── backend_rust/          # Rust Backend Service
│
└── README.md
```

---

# Tech Stack

## Frontend

- Flutter
- Dart
- Provider
- Google Maps Flutter
- Firebase Messaging
- Shared Preferences
- HTTP Package

## Backend

- Django 5
- Django REST Framework
- Daphne (ASGI Server)
- Celery
- Redis
- Firebase Admin SDK
- MongoDB

## Rust Service

- Rust
- Actix Web
- MongoDB
- AWS S3
- Shuttle

---

# Prerequisites

Before running this project, make sure the following software is installed.

## Flutter

- Flutter SDK (3.7 or later)
- Android Studio
- Android SDK
- VS Code (optional)

Verify your Flutter installation:

```bash
flutter doctor
```

---

## Django Backend

You can either use Docker (recommended) or install Python manually.

### Required

- Docker Desktop

or

- Python 3.12+
- pip

---

## Rust Backend

Install the latest stable Rust compiler.

```bash
rustup install stable
```

---

# Clone the Repository

```bash
git clone https://github.com/Hanhan-23/Balap-inV2Mobile.git

cd Balap-inV2Mobile
```

---

# Running the Django Backend

Navigate to the backend directory.

```bash
cd backend_django
```

## Option 1 — Using Docker (Recommended)

Build the Docker image.

```bash
docker compose build
```

Start all services.

```bash
docker compose up
```

The following services will be started:

- Django API
- Redis
- Celery Worker
- Celery Beat

The API will be available at

```
http://localhost:8000
```

---

## Option 2 — Without Docker

Create a virtual environment.

```bash
python -m venv venv
```

Activate it.

### Windows

```bash
venv\Scripts\activate
```

### Linux / macOS

```bash
source venv/bin/activate
```

Install all required packages.

```bash
pip install -r requirements.txt
```

Run database migrations.

```bash
python manage.py migrate
```

Start the development server.

```bash
python manage.py runserver
```

---

# Environment Configuration

Create a `.env` file inside the `backend_django` directory and configure all required environment variables.

```text
backend_django/.env
```

The backend also requires a Firebase Admin SDK credential file.

Place it here:

```text
backend_django/serviceAccountKey.json
```

---

# Running the Flutter Application

Navigate to the frontend directory.

```bash
cd frontend
```

Install Flutter dependencies.

```bash
flutter pub get
```

Make sure an Android emulator or physical device is connected.

Run the application.

```bash
flutter run
```

---

# Building the APK

Debug build

```bash
flutter build apk
```

Release build

```bash
flutter build apk --release
```

---

# Configure the API Base URL

Update the backend API endpoint in the Flutter service configuration.

Example location:

```text
frontend/lib/services/service.dart
```

Replace the base URL with your server address.

Examples:

```text
http://10.0.2.2:8000
```

or

```text
http://127.0.0.1:8000
```

or your production server URL.

---

# Running the Rust Backend

Navigate to the Rust backend.

```bash
cd backend_rust
```

Build the project.

```bash
cargo build
```

Run the server.

```bash
cargo run
```

---

# Firebase Configuration

This project uses Firebase for:

- Push Notifications
- Firebase Cloud Messaging (FCM)
- Firebase Admin SDK

Required files:

Android application

```text
frontend/android/app/google-services.json
```

Backend

```text
backend_django/serviceAccountKey.json
```

---

# Google Maps Configuration

This application uses the Google Maps SDK.

Make sure your Google Maps API key is properly configured in:

```text
frontend/android/app/src/main/AndroidManifest.xml
```

Enable the required APIs in the Google Cloud Console before running the application.

---

# Troubleshooting

## Flutter cannot detect a device

```bash
flutter doctor
```

---

## Dependency installation issues

```bash
flutter clean

flutter pub get
```

---

## Docker services fail to start

Ensure Docker Desktop is running.

Check active containers.

```bash
docker ps
```

---

## Celery is not processing tasks

Verify that Redis is running.

Default Redis port:

```text
localhost:6379
```

---

# Contributors

- Farhan Ramadhan
- Yulia Pipka Ziliwu
- M. Iskandar Dinata
- Michael Lee

---

# License

This project was developed as part of the **BALAP-IN** road infrastructure reporting system for academic purposes at **Politeknik Negeri Batam**.

Feel free to use and modify this project for educational purposes.