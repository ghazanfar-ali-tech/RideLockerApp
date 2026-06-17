import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';

class UserProvider with ChangeNotifier {
  String name = '';
  String phone = '';
  String email = '';
  String? imageUrl;

  Uint8List? imageBytes;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> loadUser() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final data = doc.data();

    if (data != null) {
      name = data['name'] ?? '';
      phone = data['phone'] ?? '';
      email = data['email'] ?? '';
      imageUrl = data['imageUrl'];

      notifyListeners();
    }
  }

  void setImageBytes(Uint8List bytes) {
    imageBytes = bytes;
    notifyListeners();
  }

  void setImageUrl(String url) {
    imageUrl = url;
    notifyListeners();
  }

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  Future<void> saveProfile() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
  }
}
