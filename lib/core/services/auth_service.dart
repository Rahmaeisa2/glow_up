import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:glow_up_app/core/routes/app_route.dart';

class AuthService{
  final firebase_auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<User?> signInWithEmail (String email, String Password , context) async {
    try {

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: Password);

      final user = FirebaseAuth.instance.currentUser;
      if(user!=null && user.emailVerified){
        print("email is varified , login ${user.email}");
        Navigator.pushNamed(context, AppRoutes.questions);
      }else{
        print("email is not verified");
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'Email not verified',
          desc: 'Please verify your email before logging in.',
          btnOkOnPress: () async {
            await user?.sendEmailVerification();
          },
        ).show();
      }
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuthException: ${e.code} - ${e.message}");

      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address format.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid email or password.';
          break;
        default:
          errorMessage = e.message ?? 'Login failed. Please try again.';
      }

      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Login Error',
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      print("⚠️ General Error: $e");
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Something went wrong. Please try again.',
        btnOkOnPress: () {},
      ).show();
    }
    return null;

  }


}