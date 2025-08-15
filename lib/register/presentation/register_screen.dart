import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theming/app_color.dart';
import '../../test.dart';

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
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          // ابعت رسالة تأكيد على الإيميل
                          await FirebaseAuth.instance.currentUser!.sendEmailVerification();

                          // اعرضي رسالة تنبيه للمستخدم
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'تم إنشاء الحساب',
                            desc: 'تم إرسال رسالة تأكيد إلى بريدك الإلكتروني. من فضلك قم بتأكيد بريدك ثم قم بتسجيل الدخول.',
                            btnOkText: "حسناً",
                            btnOkOnPress: () {
                              Navigator.of(context).pushReplacementNamed("login");
                            },
                          )..show();

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.rightSlide,
                              title: 'password is week',
                              desc: 'Please chiose passowrd stronger',
                              btnOkOnPress: () {},
                            )..show();

                          } else if (e.code == 'email-already-in-use') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.rightSlide,
                              title: 'الإيميل مستخدم مسبقاً',
                              desc: 'هذا البريد مستخدم بالفعل من قبل حساب آخر.',
                              btnOkOnPress: () {},
                            )..show();
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }

                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}
