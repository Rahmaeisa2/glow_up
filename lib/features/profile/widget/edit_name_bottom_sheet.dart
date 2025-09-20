import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/theming/app_color.dart';
import '../../../core/widget/custom_button.dart';
import '../../../core/widget/custom_text_form_field.dart';
class EditNameBottomSheet extends StatefulWidget {
  final TextEditingController nameController;
  final VoidCallback onSave;

  const EditNameBottomSheet({super.key, required this.nameController, required this.onSave});

  @override
  State<EditNameBottomSheet> createState() => _EditNameBottomSheetState();
}

class _EditNameBottomSheetState extends State<EditNameBottomSheet> {

  late TextEditingController _nameController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   InkWell(
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
            child: Icon(Icons.edit_note_sharp , size: 25,)));


  }
}
