import 'package:flutter/material.dart';
class BuildNutritionCard extends StatelessWidget {
 final  String value;
 final String title;
  const BuildNutritionCard({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          padding:  EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color:Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            value,
            style:Theme.of(context).textTheme.labelLarge!.copyWith(

                color: Theme.of(context).colorScheme.surface
            ),        ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style:Theme.of(context).textTheme.labelLarge!.copyWith(

    color: Theme.of(context).colorScheme.primaryFixed
    )),
      ],
    );
  }
}
