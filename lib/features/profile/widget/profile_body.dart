import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:ffi';
import '../../../core/routes/app_route.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/widget/custom_button.dart';
import 'Image_Picker_Bottom_Sheet.dart';
import 'data_card.dart';

class ProfileBody extends StatelessWidget {
  final Map<String, dynamic> userData;
  final User? user;
  final XFile? image;
  final ImagePicker picker = ImagePicker();
  final Future<void> Function() pickFromGallery;
  final Future<void> Function() pickFromCamera;
  final Future<void> Function() logout;

  ProfileBody({super.key, required this.userData, this.user, this.image, required this.pickFromGallery, required this.pickFromCamera, required this.logout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 70),
                height: 250,
                width: 360,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]

                ),
                child:
                      DataCard(userData: userData),


              ),
              Positioned(
                top: -36, left: 0,
                right: 0,

                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (BuildContext context) {
                        return ImagePickerBottomSheet(
                          onPickFromGallery: pickFromGallery,
                          onPickFromCamera: pickFromCamera,
                        );
                      },
                    );
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
                          : null,
                    ),
                    child:image == null
                        ? Icon(Icons.person, size: 50, color: Colors.grey[600])
                        : null,
                  ),
                ),
              )
            ]),
        SizedBox(height: 23,),
        Text  ( userData['email'] ?? "not found",
          overflow: TextOverflow.clip,
          maxLines: 3,
          style: GoogleFonts.aDLaMDisplay(
            textStyle:  TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,),
          ),),
        SizedBox(height: 23,),

        Divider(
          color: Colors.grey,
          thickness: 2,
          endIndent: 23,
          indent: 23,
        ),
        SizedBox(height: 30,),
        CustomButton(
            background:Theme.of(context).primaryColor,
            name: "Logout", onTap: ()async{
          logout();

          final prefs = await SharedPreferences.getInstance();
          await prefs.remove("onboarding_completed");
          Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
        })
      ],
    );

  }
}
