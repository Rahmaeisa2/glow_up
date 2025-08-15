import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(leading: InkWell(
        onTap:(){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new_rounded ,
        size: 20,),
      ),),
    );
  }
}
