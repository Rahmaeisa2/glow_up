import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/login/presentation/login_screen.dart';
import 'package:glow_up_app/register/presentation/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/widget/responsive.dart';

class FristScreen extends StatelessWidget {
  const FristScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
       // elevation: 1,
        leading: InkWell(
          onTap: (){
          Navigator.pop(context);
  },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 60
        ),
        child: Center(
          child: Column (
            children: [
               Image.asset("assets/images/fit.jpeg" ,
                 height: 250,
                 width: double.infinity,
               ),
              Text("HELLO!",
                style: GoogleFonts.alexandria(
                  textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 7),
              Text(
                textAlign: TextAlign.center
                ,"Get ready to push limits.\nYour transformation starts now.",
                style: GoogleFonts.aDLaMDisplay(
                  textStyle: TextStyle(
                    color: ColorsApp.p,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              CustomButton(name: "Login", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }),
              SizedBox(
                height: 15,
              ),
              CustomButton(name: "Register", background: ColorsApp.p, onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
              })


            ],
          ),
        ),
      ),
    );
}}
