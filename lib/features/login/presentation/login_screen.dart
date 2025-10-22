import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_up_app/core/widget/custom_button.dart';
import 'package:glow_up_app/core/widget/custom_text_form_field.dart';
import 'package:glow_up_app/core/widget/user-answers.dart';
import 'package:glow_up_app/test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/app_route.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/widget/responsive.dart';
import '../../question/provider/user_onboarding_provider.dart';

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
  late final provider = Provider.of<UserOnboardingProvider>(context, listen: false);

  late final dataToSave =provider.user.name;

  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<UserOnboardingProvider>(context);
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.maybePop(context);
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
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(" Login" ,
                  style:Theme.of(context).textTheme.displayMedium?.copyWith(
              color:
              Theme.of(context).colorScheme.primary,),),
                  SizedBox(height: 9,),
                  Text("Please Sign in to continue " ,
                    style:Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color:
                        Theme.of(context).colorScheme.primary,),),
                  const SizedBox(
                    height: 50
                  ),
                  CustomTextFormField(
                      onChanged: provider.updateName,
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
                      background: Theme.of(context).colorScheme.primary,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          var email = loginController.text.trim();
                          var password = passwordController.text.trim();

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
                          await AuthService.signInWithEmail(
                              loginController.text.trim(),
                              passwordController.text.trim(),
                            context=context

                          );
                        }}
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                      children: [
                        Checkbox(
                            activeColor: Theme.of(context).colorScheme.onSecondary,
                            value: value, onChanged: (bool? newValue) {
                          setState(() {
                            value = newValue!;
                          });
                        }),
                        Text("Remember me?",style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary
                          )),
                        
                        TextButton(onPressed: ()async{
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: loginController.text.trim());

                        }, child: Text(
                        "Forget Password?" ,
                        style:Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 13.sp,
                            color: Theme.of(context).colorScheme.primary
                        )
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
                        style:  Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surfaceContainer
                  )),
                      TextButton(onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      }
                      , child: Text(
                        "Sing Up",
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary
                          )))
                    ],
                  )

                ],),
          ),
        ),
      ),
    );
  }
}
