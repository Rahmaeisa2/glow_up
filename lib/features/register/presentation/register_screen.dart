import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/routes/app_route.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/widget/responsive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController =TextEditingController();
  TextEditingController nameController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController confirmController =TextEditingController();
  bool _isObscure=true;
  final formKey =GlobalKey<FormState>();
  bool value = false;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 20
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Register",
              style: GoogleFonts.aDLaMDisplay(
                textStyle: const TextStyle(
                    color: ColorsApp.p,
                    fontSize: 28,
                    fontWeight: FontWeight.w400
                ),
              )),
                Text("Let's get started",
                      style: GoogleFonts.aDLaMDisplay(
                        textStyle: const TextStyle(
                          color: ColorsApp.p,
                          fontSize: 20,
                        ),
                    )),
                const SizedBox(
                    height: 22
                ),
                CustomTextFormField(
                    prefixIcon: Icons.person,
                    isObscure: _isObscure,
                    onToggle: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },hintText: "Name", title: "Name", controller:nameController ,
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;}),
                const SizedBox(height: 10,),
                CustomTextFormField(

                  prefixIcon: Icons.email,

                  isObscure: _isObscure,
                  onToggle: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },hintText: "Email", title: "Email", controller:emailController ,
                validator: (value){
                  if(value== null || value.isEmpty){
                    return "Please enter your email";
                  }
                  return null;
                },
                ),
                const SizedBox(height: 10,),
                CustomTextFormField(
                  isPassword: true,
                    prefixIcon: Icons.password,

                    isObscure: _isObscure,
                    onToggle: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },hintText: "Password", title: "Password", controller:passwordController ,
                    validator: (value){
                      if(value== null || value.isEmpty){
                        return "Please enter your password";
                      }
                      return null;
                    }),
                const SizedBox(height: 10,),
                CustomTextFormField(
                  isPassword: true,
                    prefixIcon: Icons.password,
                    isObscure: _isObscure,
                    onToggle: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    hintText: "Confirm Password", title: "Confirm Password", controller:confirmController ,

                    validator: (value){
                      if(value== null || value.isEmpty){
                        return "Please enter your password";
                      }else if(confirmController.text!=passwordController.text){
    return "confirmation password must be same as password";
                    }}
                ),
                const SizedBox(height: 17,),
                CustomButton(
                  name: "Register",
                  background: ColorsApp.p,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          await FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();

                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Account Created',
                            desc: 'A confirmation email has been sent to your email address. Please confirm your email before logging in.',
                            btnOkText: "OK",
                            btnOkOnPress: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                          )
                            ..show();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.rightSlide,
                              title: 'Weak Password',
                              desc: 'Please choose a stronger password.',
                              btnOkOnPress: () {},
                            )
                              ..show();
                          } else if (e.code == 'email-already-in-use') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.rightSlide,
                              title: 'Email Already in Use',
                              desc: 'This email is already associated with another account.',
                              btnOkOnPress: () {},
                            )
                              ..show();
                          }
                        } catch (e) {
                          print(e);
                        }
                      }}
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}
