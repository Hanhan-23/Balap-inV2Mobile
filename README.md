# 🚧 BALAP-IN V2 Mobile

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
![Django](https://img.shields.io/badge/Django-5-092E20?style=for-the-badge&logo=django)
![Rust](https://img.shields.io/badge/Rust-Backend-black?style=for-the-badge&logo=rust)
![MongoDB](https://img.shields.io/badge/MongoDB-Database-47A248?style=for-the-badge&logo=mongodb)
![Redis](https://img.shields.io/badge/Redis-Background%20Task-DC382D?style=for-the-badge&logo=redis)
![License](https://img.shields.io/badge/License-Educational-blue?style=for-the-badge)

**A cross-platform mobile application for reporting, monitoring, and managing road infrastructure issues in Batam City.**

</div>

---

# Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Django Backend](#running-the-django-backend)
- [Running the Flutter Application](#running-the-flutter-application)
- [Running the Rust Backend](#running-the-rust-backend)
- [Quick Start](#quick-start)
- [Environment Configuration](#environment-configuration)
- [Firebase Configuration](#firebase-configuration)
- [Google Maps Configuration](#google-maps-configuration)
- [Building the APK](#building-the-apk)
- [Troubleshooting](#troubleshooting)
- [Contributors](#contributors)
- [License](#license)

---

# Overview

BALAP-IN (Batam Road Infrastructure Reporting System) is a cross-platform mobile application developed to help citizens report road infrastructure issues in Batam City.

The system consists of three main components:

- 📱 Flutter Mobile Application
- 🚀 Django REST API Backend
- ⚡ Rust Backend Service

The application provides location-based reporting, interactive maps, image uploads, push notifications, and background processing for efficient infrastructure management.

---

# Features

- Cross-platform mobile application built with Flutter
- Google Maps integration
- Location-based road damage reporting
- Image upload support
- Firebase Cloud Messaging (FCM)
- RESTful API powered by Django
- High-performance backend service built with Rust
- Background task processing using Celery
- Redis message broker
- MongoDB database support

---

# Project Structure

```text
Balap-inV2Mobile/
│
├── frontend/                 # Flutter Mobile Application
│
├── backend_django/           # Django REST API Backend
│
├── backend_rust/             # Rust Backend Service
│
└── README.md
```

---

# Technology Stack

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

## Rust Backend

- Rust
- Actix Web
- MongoDB
- AWS S3
- Shuttle

---

# Prerequisites

Before running this project, install the following software.

## Flutter

- Flutter SDK 3.x
- Android Studio
- Android SDK
- VS Code (optional)

Verify Flutter installation.

```bash
flutter doctor
```

---

## Django Backend

Install either:

- Docker Desktop (Recommended)

or

- Python 3.12+
- pip

---

## Rust Backend

Install Rust.

```bash
rustup install stable
```

Verify installation.

```bash
rustc --version
cargo --version
```

---

# Installation

## Step 1 — Clone the Repository

Clone the repository from GitHub.

```bash
git clone https://github.com/Hanhan-23/Balap-inV2Mobile.git
```

Navigate to the project.

```bash
cd Balap-inV2Mobile
```

Project structure.

```text
Balap-inV2Mobile/
│
├── frontend/
├── backend_django/
├── backend_rust/
└── README.md
```

---

# Running the Django Backend

Navigate to the backend.

```bash
cd backend_django
```

## Option 1 — Docker (Recommended)

Build Docker images.

```bash
docker compose build
```

Run all services.

```bash
docker compose up
```

This will start:

- Django API
- Redis
- Celery Worker
- Celery Beat

Backend URL

```
http://localhost:8000
```

---

## Option 2 — Local Installation

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

Install dependencies.

```bash
pip install -r requirements.txt
```

Run database migrations.

```bash
python manage.py migrate
```

Start Django.

```bash
python manage.py runserver
```

---

# Environment Configuration

Create a `.env` file.

```text
backend_django/.env
```

Configure all required environment variables.

The backend also requires:

```text
backend_django/serviceAccountKey.json
```

This file is used by Firebase Admin SDK.

---

# Running the Flutter Application

Open another terminal.

Navigate to the frontend.

```bash
cd frontend
```

Install dependencies.

```bash
flutter pub get
```

Verify connected devices.

```bash
flutter devices
```

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

Update the backend endpoint.

Example file:

```text
frontend/lib/services/service.dart
```

Example URLs.

Android Emulator

```text
http://10.0.2.2:8000
```

Localhost

```text
http://127.0.0.1:8000
```

Production

```text
https://your-domain.com
```

---

# Running the Rust Backend

Open another terminal.

Navigate to the Rust project.

```bash
cd backend_rust
```

Build the application.

```bash
cargo build
```

Run the server.

```bash
cargo run
```

---

# Quick Start

After cloning the repository, run each component in a separate terminal.

## Terminal 1 — Django Backend

```bash
cd backend_django

python -m venv venv

# Windows
venv\Scripts\activate

# Linux/macOS
source venv/bin/activate

pip install -r requirements.txt

python manage.py migrate

python manage.py runserver
```

---

## Terminal 2 — Flutter Mobile

```bash
cd frontend

flutter pub get

flutter run
```

---

## Terminal 3 — Rust Backend

```bash
cd backend_rust

cargo build

cargo run
```

---

### Application Services

| Service | Address |
|----------|----------|
| Flutter Application | Android Emulator / Physical Device |
| Django API | http://127.0.0.1:8000 |
| Rust Service | Configured Port |

---

# Firebase Configuration

This project uses Firebase for:

- Push Notifications
- Firebase Cloud Messaging (FCM)
- Firebase Admin SDK

Required files.

Android

```text
frontend/android/app/google-services.json
```

Backend

```text
backend_django/serviceAccountKey.json
```

---

# Google Maps Configuration

Configure your Google Maps API Key in:

```text
frontend/android/app/src/main/AndroidManifest.xml
```

Enable:

- Maps SDK for Android
- Places API
- Geocoding API

---

# Troubleshooting

## Flutter cannot detect devices

```bash
flutter doctor
```

---

## Dependency Issues

```bash
flutter clean

flutter pub get
```

---

## Docker Issues

Ensure Docker Desktop is running.

```bash
docker ps
```

---

## Celery is not processing tasks

Verify Redis.

```bash
redis-cli ping
```

Expected output

```text
PONG
```

---

## Rust Build Issues

Update Rust.

```bash
rustup update
```

Clean previous builds.

```bash
cargo clean

cargo build
```

---

# Contributors

- Farhan Ramadhan
- Yulia Pipka Ziliwu
- M. Iskandar Dinata
- Michael Lee

---

# License

This project was developed as part of the **BALAP-IN (Batam Road Infrastructure Reporting System)** at **Politeknik Negeri Batam**.

The source code is provided for educational and research purposes. Feel free to use and modify it in accordance with your institution's guidelines.