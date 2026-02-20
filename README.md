📘 FlexEdu – AI-Powered Adaptive Learning Platform
🚀 Overview

FlexEdu is an AI-driven personalized learning platform that dynamically adapts educational content based on each user's learning style.

The system combines machine learning, generative AI, and full-stack development to deliver tailored learning experiences across mobile and web platforms.

The platform detects a user’s learning style using behavioral interaction data and quiz performance, then generates customized content accordingly.

🎯 Key Features

🔍 Learning Style Detection (ML-Based)

XGBoost model trained on user interaction and quiz performance data

Automated classification into VARK learning styles

🤖 AI-Powered Content Generation

Dynamic text generation

AI-generated educational images

Text-to-Speech for auditory learners

Adaptive lesson rendering

📱 Cross-Platform Application

Mobile app built with Flutter

Web application with modern frontend stack

Responsive UI and multi-device support

🔐 Secure Authentication & Data Handling

Firebase Authentication

Role-based access (User / Admin)

Secure token validation via Firebase Admin SDK

📊 Progress Tracking & Analytics

Real-time progress reports

Quiz performance tracking

Learning history logging

💳 Payment Integration

Subscription handling via Paymob

Secure transaction confirmation

🏗️ System Architecture

FlexEdu follows a modular architecture:

Frontend (Flutter + Web)
⬇
Firebase (Auth + Firestore + Storage)
⬇
Python Flask Backend
⬇
Machine Learning Model (XGBoost)
⬇
Generative AI APIs

This architecture ensures:

Scalability

Modularity

Secure API communication

Independent service deployment

🧠 Machine Learning Component

Model: XGBoost Classifier

Input: User interaction metrics + quiz performance

Output: Learning style prediction

Deployment: Flask REST API

The predicted learning style dynamically controls lesson presentation logic.

🛠️ Technology Stack
Mobile

Flutter (Dart)

Bloc / Cubit (State Management)

Firebase Core Services

Web

React / Next.js

Node.js REST APIs

TypeScript

Backend & AI

Python

Flask

XGBoost

Pandas / NumPy

Joblib

AI & External APIs

Gemini API (Generative Text)

Stability AI (Image Generation)

Google TTS (Audio Generation)

Infrastructure

Firebase Firestore

Firebase Storage

Firebase Hosting

CI/CD via GitHub Actions

🔬 Testing Strategy

Unit Testing (Frontend + Backend)

Integration Testing (Flutter ↔ Firebase ↔ ML)

API Testing (Postman)

UI Testing

Role-Based Access Validation

Error Handling & Edge Case Testing

📈 Scalability & Security

Modular microservice-ready architecture

Secure RESTful APIs

Encrypted authentication flows

GDPR-aware data handling

Cloud-ready deployment

📌 Future Enhancements

Advanced deep learning learning-style detection

AR/VR learning modules

Parent/Teacher analytics dashboards

Offline-first learning mode

Multilingual support

Institutional licensing model
