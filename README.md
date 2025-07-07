# Flutter-Firebase Chat App <br />
A cross-platform real-time chat application built using Flutter and Firebase. This app supports email/password authentication and enables users to exchange messages instantly, using Firestore as the backend. It is compatible with Android, iOS, Web, and Desktop platforms <br />

## Features
<pre>
1.User Authentication (Sign Up / Sign In) via Firebase Auth
2.Real-time messaging using Cloud Firestore
3.Supports Android, iOS, Web, Windows, macOS, and Linux
</pre>
## Project Structure <br />
<pre>
lib/
├── main.dart                  # Entry point
├── firebase_options.dart      # Firebase config
├── screens/
│   ├── splash.dart            # Auto-login check
│   ├── auth.dart              # Sign up / Sign in
│   └── chat.dart              # Chat screen layout
└── widgets/
    ├── chat_messages.dart     # List of all messages (StreamBuilder)
    ├── message_bubble.dart    # Chat bubble UI
    └── new_message.dart       # Input + send button
</pre>

## Firebase Setup
<pre>
1.Create a project in Firebase Console.
2.Enable Authentication → Email/Password.
3.Create Firestore Database → Start in test mode (or use secure rules).
4.Add a users collection to store username for each user.
5.Use FlutterFire CLI to configure.
</pre>

## Getting Started
#### Prerequisites
<pre>
1.Flutter SDK installed (flutter.dev).
2.Firebase project setup.
3.Android Studio or VS Code (with Flutter plugins) .
</pre>
#### Run Locally
<pre>
1.git clone https://github.com/<Srivatsan8055>/chat-app.git
2.cd flutter-chat-app
3.flutter pub get
4.flutterfire configure  # If not already done
5.flutter run
</pre>

## Tech Stack
<pre>
Frontend : Flutter (Dart)
Backend : Firebase (Auth, Firestore)
</pre>

## Firestore Database Security
Go to Firestore → Database → Rules and restict access to firestore.
<pre>
        rules_version = '2';
        service cloud.firestore {
          match /databases/{database}/documents {
            match /{document=**} {
              allow read, write: if request.auth != null;
            }
          }
        }
</pre>
