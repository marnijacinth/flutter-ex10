import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

/// Handles all Firestore-related operations for the Product Inventory project.
/// Currently supports manual user login validation, but can be expanded
/// to include product search, updates, etc.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// 🔐 Verifies user login credentials stored in Firestore `users` collection.
  ///
  /// Returns:
  /// - `Map<String, dynamic>` → user details (name, email, id)
  /// - `null` → if no match or invalid credentials
  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      developer.log('🚀 Checking credentials for email: $email');
      final col = _db.collection('users');

      // Query Firestore for the given email
      final query = await col.where('email', isEqualTo: email).get();
      developer.log('📊 Found ${query.docs.length} document(s) for $email');

      if (query.docs.isEmpty) {
        developer.log('❌ No user found for email: $email');
        return null;
      }

      // Validate password manually
      for (final doc in query.docs) {
        final data = doc.data();
        final storedPassword = data['password']?.toString() ?? '';

        developer.log('🔐 Comparing passwords...');
        developer.log('   → Entered: "$password" (${password.length} chars)');
        developer.log('   → Stored:  "$storedPassword" (${storedPassword.length} chars)');

        if (storedPassword == password) {
          developer.log('✅ Login successful for ${data['email']}');
          return {
            'id': doc.id,
            'email': data['email'] ?? '',
            'name': data['name'] ?? '',
          };
        }
      }

      developer.log('❌ Password mismatch for email: $email');
      return null;
    } catch (e) {
      developer.log('🔥 FirestoreService Error: $e');
      return null;
    }
  }

  // 🧩 Future: You can easily extend this for product management (Exercises 8 & 9)
  //
  // Example:
  // Future<List<Map<String, dynamic>>> getAllProducts() async { ... }
  // Future<void> updateProduct(String id, double price) async { ... }
}
