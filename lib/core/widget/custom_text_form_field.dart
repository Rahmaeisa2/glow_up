import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String title;
  final IconData? prefixIcon;
  final IconData?suffixIcon;

  final bool isPassword;
  final bool isObscure;
  final VoidCallback? onToggle;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  void Function(String)? onChanged;

   CustomTextFormField({
    super.key,
     this.hintText,
    required this.title,
    this.prefixIcon,
    required this.controller,
    this.validator,
    this.isPassword = false,
    this.isObscure = false,
    this.onChanged,
    this.onToggle, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,

      style:
        Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).primaryColor,
        ),
        ),
         SizedBox(height: 9),
        TextFormField(
          onChanged: onChanged,
          obscureText: isPassword ? isObscure : false,
          keyboardType: title == "Password"
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon:  prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: onToggle,
            )
                : null,
            hintText: hintText,
            border:Theme.of(context).inputDecorationTheme.enabledBorder
          ),
        ),
      ],
    );
  }
}
