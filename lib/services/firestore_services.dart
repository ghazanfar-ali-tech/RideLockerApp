import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user id
  String get uid => _auth.currentUser!.uid;

  /// =========================
  /// CREATE / UPDATE USER DATA
  /// =========================
  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required String email,
    String? imageUrl,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'imageUrl': imageUrl ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception("Failed to update profile: $e");
    }
  }

  /// =========================
  /// GET USER STREAM (REAL-TIME)
  /// =========================
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  /// =========================
  /// GET USER ONCE (ONE TIME LOAD)
  /// =========================
  Future<Map<String, dynamic>?> getUserOnce() async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  /// =========================
  /// UPDATE ONLY IMAGE
  /// =========================
  Future<void> updateProfileImage(String imageUrl) async {
    await _firestore.collection('users').doc(uid).set({
      'imageUrl': imageUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
