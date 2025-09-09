import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:glow_up_app/question/presentation/question_onboarding.dart';
import 'package:glow_up_app/test.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/routes/app_route.dart';
import '../../core/theming/app_color.dart';
import '../../core/widget/responsive.dart';
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
  final dataToSave =UserAnswer.email;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

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
            horizontal: 21,
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
                      }, onChanged: (value) {
                    UserAnswer.email =value;},
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                      hintText: "Email", title: "Email", controller: loginController),
                  const SizedBox(height: 17,),
                  CustomTextFormField(
                    isPassword: true,
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
                } ,
                      hintText: "Password", title: "Password", controller: passwordController),
                  const SizedBox(height: 25,),
                  CustomButton(name: "Login",
                      background:ColorsApp.p,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final email = loginController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            await AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Missing Information',
                              desc: 'Please enter both email and password.',
                              btnOkOnPress: () {},
                            ).show();
                            return;
                          }

                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(email: email, password: password);

                            final user = FirebaseAuth.instance.currentUser;

                            if (user != null && user.emailVerified) {
                              print("✅ Email verified. Logged in: ${user.email}");
                              Navigator.pushNamed(context, AppRoutes.questions);
                            } else {
                              print("⚠️ Email not verified.");
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
                        }
                      }

                  ),
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
                            fontSize: 13,
                            fontWeight: FontWeight.w600,

                          ),),),
                        SizedBox(
                          width: 7,
                        ),
                        TextButton(onPressed: ()async{
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: loginController.text.trim());

                        }, child: Text(
                        "Forget Password?" ,
                        style: GoogleFonts.alexandria(
                          textStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,

                          ),),
                      )),
                      ],
                    ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: GoogleFonts.alexandria(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,

                          ),),),
                      TextButton(onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      }
                      , child: Text(
                        "Sing Up",
                          style: GoogleFonts.alexandria(
                            textStyle: TextStyle(
                              fontSize: 15,
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
