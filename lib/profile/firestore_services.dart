import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
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
        final data = doc.data();
        if (data != null && data.containsKey('onboarding')) {
          return data['onboarding'] as Map<String, dynamic>;
        }
        return data;
      }
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
