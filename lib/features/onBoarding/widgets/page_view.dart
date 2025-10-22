import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class PageViewItem extends StatelessWidget {
  final String? imageURL;
  final String text;
  final String text2;

  const PageViewItem({super.key,  this.imageURL, required this.text, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageURL != null
            ? Image.asset(imageURL!)
            : const Placeholder(fallbackHeight: 150),
      SizedBox(
        height: 28,

      ),
        Text(text ,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
    color: Theme.of(context).colorScheme.primary,
    )
        ),

        SizedBox(
          height: 13,
        ),

        Text(textAlign: TextAlign.center,
          text2,
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
      color: Theme.of(context).colorScheme.onBackground,

        ),
        )
      ],
    );
  }
}
