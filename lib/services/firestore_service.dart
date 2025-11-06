import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetches the `users` collection and returns the first user map
  /// that matches the provided email and password (manual match).
  /// Returns null if no match.
  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    final col = _db.collection('users');

    developer.log('🔍 Querying users collection for email: $email');
    final query = await col.where('email', isEqualTo: email).get();
    developer.log(
      '📊 Found ${query.docs.length} document(s) with email: $email',
    );

    if (query.docs.isEmpty) {
      developer.log('❌ No user found with email: $email');
      return null;
    }

    for (final doc in query.docs) {
      final data = doc.data();
      final stored = data['password']?.toString() ?? '';
      developer.log('🔐 Comparing passwords:');
      developer.log('   Entered: "$password" (length: ${password.length})');
      developer.log('   Stored:  "$stored" (length: ${stored.length})');
      developer.log('   Match: ${stored == password}');

      if (stored == password) {
        developer.log('✅ Login successful for ${data['email']}');
        // Return a normalized map
        return {
          'id': doc.id,
          'email': data['email'] ?? '',
          'name': data['name'] ?? '',
        };
      }
    }

    developer.log('❌ No password match found for email: $email');
    return null;
  }
}
