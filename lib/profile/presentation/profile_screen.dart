import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:glow_up_app/profile/firestore_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get current user
  late TextEditingController _nameController =TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // (prepare)data for current user
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  late final User user;
  bool loading=false;

  XFile? image;
  PickFromCamera()async{
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if(pickedImage !=null ){
      setState(() {
        image = pickedImage;
      });
    }else{
      return " Please select picture";
    }
  }
  PickFromGallery ()async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        image=pickedImage;
      });
    }
  }

  Future<void> _updateData() async {
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
  final FirestoreService firestoreServices = FirestoreService();
  @override
  void initState() {
    super.initState();
    user = _auth.currentUser!;
    _nameController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profiler",style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
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


            return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                alignment: Alignment.bottomRight,

                children:[
                InkWell(
                  onTap: (){

                    showModalBottomSheet(context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (BuildContext context){
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 18
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(name: "Upload from gallery", onTap: PickFromGallery),
                            SizedBox(
                              height: 14,
                            ),
                            CustomButton(name: "Capture pic", onTap: PickFromCamera),
                          ],
                        ),
                      );
                    });
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                              image: image != null
                                  ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(image!.path)),
                              )
                                  : null,),

                  child: image == null
                      ? Icon(Icons.camera_alt, color: Colors.white, size: 21)
                      : null,

                  ),
                ),]
            ),
            SizedBox(width: 40,),
            Column(

              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(userData['name'] ?? "No Name",
                style:  GoogleFonts.aDLaMDisplay(
                  textStyle:  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,),
                ),
              ),SizedBox(width: 12,),
              InkWell(
                  onTap:(){
                    showModalBottomSheet(context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (BuildContext context){
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 18
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFormField(
                                title: "Edit name",
                                controller: _nameController),
                            SizedBox(
                              height: 12,
                            ),
                            CustomButton(background: ColorsApp.p,
                                name:" Save", onTap: (){
                                _updateData();
                                Navigator.pop(context);
                              },




                            )
                          ]
                        ),
                      );
                    });
                  },
                  child: Container(
                height: 40,
                width: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(color: ColorsApp.p)
                ),
                  child: Icon(Icons.edit_note_sharp , size: 25,)))

            ],),

          ],
        ),
        ]
      ),);}
    ));}
  }

