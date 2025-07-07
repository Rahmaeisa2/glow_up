import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:glow_up_app/question/presentation/question_onboarding.dart';
import 'package:glow_up_app/test.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theming/app_color.dart';
import '../../register/presentation/register_screen.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false;
  bool _isObscure = true;

  final formKey = GlobalKey<FormState>();

  TextEditingController loginController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined ,
          size: 22,),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 70
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(" Welcome back" ,
                  style: GoogleFonts.aDLaMDisplay(
                    textStyle: const TextStyle(
                        color: ColorsApp.p,
                        fontSize: 28,
                        fontWeight: FontWeight.w400
                    ),
                  ),),
                  Text(" Login to continue " ,
                    style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                          color: ColorsApp.p,
                          fontSize: 20,
                      ),
                    ),),
                  const SizedBox(
                    height: 50
                  ),
                  CustomTextFormField(
                      isObscure: _isObscure,
                      onToggle: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                      hintText: "Email", title: "Email", controller: loginController),
                  const SizedBox(height: 17,),
                  CustomTextFormField(
                      isObscure: _isObscure,
                      onToggle: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },

                    validator: (value) {
                    if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                    }else if (value.length <8){
                      return "password must be 8 char";

                    }
                } ,
                      hintText: "Password", title: "Password", controller: passwordController),
                  const SizedBox(height: 25,),
                  CustomButton(name: "Login",
                      background:ColorsApp.p,
                      onTap: (){
                    if(formKey.currentState!.validate()){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionOnBoarding(

                      )));
                    }
                      }),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                      children: [
                        Checkbox(
                            activeColor: ColorsApp.p,
                            value: value, onChanged: (bool? newValue) {
                          setState(() {
                            value = newValue!;
                          });
                        }),
                        Text("Remember me?",style: GoogleFonts.alexandria(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,

                          ),),),
                        SizedBox(
                          width: 15,
                        ),
                        TextButton(onPressed: (){}, child: Text(
                        "Forget Password?" ,
                        style: GoogleFonts.alexandria(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,

                          ),),
                      )),
                      ],
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: GoogleFonts.alexandria(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,

                          ),),),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                      }
                      , child: Text(
                        "Sing Up",
                          style: GoogleFonts.alexandria(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,

                            ),),))
                    ],
                  )

                ],),
          ),
        ),
      ),
    );
  }
}
