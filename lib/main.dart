import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    // If Firebase initialization fails, we'll show an error screen below.
    runApp(FirebaseInitErrorApp(error: e.toString()));
    return;
  }

  runApp(const FirestoreLoginApp());
}

/// ✅ Main App (starts at LoginPage)
class FirestoreLoginApp extends StatelessWidget {
  const FirestoreLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Manual Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const LoginPage(),
    );
  }
}

/// ❌ If Firebase initialization fails, this widget shows an error message
class FirebaseInitErrorApp extends StatelessWidget {
  final String error;
  const FirebaseInitErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Init Error',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Initialization Error'),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Firebase failed to initialize.\nPlease check your internet connection or google-services.json file.\n\nError Details:\n$error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
