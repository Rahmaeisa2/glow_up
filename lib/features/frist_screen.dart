import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../core/theming/theming_provider.dart';
import '../core/widget/responsive.dart';
import 'login/presentation/login_screen.dart';
import 'register/presentation/register_screen.dart';

class FristScreen extends StatelessWidget {
  const FristScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
       elevation: 1,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 34,
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
                style:  Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
              SizedBox(
                height: 7),
              Text(
                textAlign: TextAlign.center
                ,"Get ready to push limits.\nYour transformation starts now.",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceTint
                )
              ),
              SizedBox(
                height: 26,
              ),
              CustomButton(
                  name: "Login", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }),
              SizedBox(
                height: 15,
              ),
              CustomButton(name: "Register", background:Theme.of(context).colorScheme.primary
            , onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
              })


            ],
          ),
        ),
      ),
    );
}}
