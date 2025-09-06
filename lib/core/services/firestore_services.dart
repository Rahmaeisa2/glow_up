import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class FirestoreService {
  String?name; String?email;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController loginController = TextEditingController();
Future<Map<String, dynamic>?> getUserData(String userId) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();

    print("userId: $userId");
    print("Document exists: ${doc.exists}");
    print("Document data: ${doc.data()}");

    if (doc.exists) {
      return doc.data(); // رجّع كل الداتا مش بس الـ onboarding
    }
    return null;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}}
