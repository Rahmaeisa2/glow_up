import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/routes/app_route.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:glow_up_app/core/services/firestore_services.dart';
import 'package:glow_up_app/features/profile/widget/data_card.dart';
import 'package:glow_up_app/features/profile/widget/profile_body.dart';
import 'package:glow_up_app/features/profile/widget/state_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/widget/responsive.dart';
import '../widget/Image_Picker_Bottom_Sheet.dart';
import '../widget/edit_name_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController loginController = TextEditingController();
final ImagePicker picker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  late String? email = user?.email;
  //get current user
  late TextEditingController _nameController =TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // (prepare)data for current user
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  XFile? image;
  Future<void> pickFromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  Future<void> pickFromCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }


  bool loading=false;
  Future<void> updateData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
        'onboarding.name': _nameController.text,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      setState(() {
        _nameController = TextEditingController();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data updated successfully!")),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating data: $e")),
      );

    }
  }
  Future<void> logout ()async{
    try{
      await FirebaseAuth.instance.signOut();


      print("user logged out");

    }catch(e){
      print("user logged out $e");

    }
  }
  final FirestoreService firestoreServices = FirestoreService();
  @override
  void initState() {
    super.initState();
    user = _auth.currentUser!;
    _nameController = TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Profiler",style:Theme.of(context).textTheme.displaySmall
        ),),
        body:FutureBuilder<Map<String, dynamic>?>(
            future: firestoreServices.getUserData(userId),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No user data found"));
              }
              final userData = snapshot.data!;


              return
               Padding(
                 padding: const EdgeInsets.symmetric(
                   horizontal: 14,
                   vertical: 37
                 ),
                 child: ProfileBody(userData: userData, pickFromGallery: pickFromGallery, pickFromCamera: pickFromCamera, logout: logout),
               );

            }
        )
    );
  }
}
