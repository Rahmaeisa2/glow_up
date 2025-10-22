import 'package:flutter/material.dart';
import 'package:glow_up_app/core/theming/app_color.dart';
import 'package:glow_up_app/features/question/provider/user_onboarding_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/widget/user-answers.dart';
import '../question_onboarding.dart';

class SliderHeightWeightScreen extends StatefulWidget {
  @override
  _SliderHeightWeightScreenState createState() => _SliderHeightWeightScreenState();
}

class _SliderHeightWeightScreenState extends State<SliderHeightWeightScreen> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
     final provider = Provider.of<UserOnboardingProvider>(context, listen: false);
     if(provider.user.height !=null){
       height = provider.user.height!;
     }
    if(provider.user.weight !=null){
      weight = provider.user.weight!;
    }

  }

double height = 160;
double weight = 60;
double sliderValue = 5;


@override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserOnboardingProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(textAlign: TextAlign.center,
              "Let's set your height & weight",
            style: Theme.of(context).textTheme.displaySmall,
                    ),
            SizedBox(height: 40),
            // Height Section
            Text("Height", style: Theme.of(context).textTheme.displaySmall,),
            SizedBox(height: 8),
            Text("${height.toInt()} cm", style: Theme.of(context).textTheme.displayMedium),
            Slider(
              onChangeEnd: (value){
              },
              min: 100,
              max: 220,
              value: height,
              activeColor:Theme.of(context).colorScheme.primary,
              onChanged: (v) {
                setState(() => height = v);
                provider.updateHeight(v.toString());
              },
            ),
            SizedBox(height: 32),

            // Weight Section
            Text("Weight",   style: Theme.of(context).textTheme.displaySmall),
            SizedBox(height: 8),
            Text("${weight.toInt()} kg", style: Theme.of(context).textTheme.displayMedium),
            Slider(
              min: 30,
              max: 150,
              value: weight,
              activeColor:Theme.of(context).colorScheme.primary,
              onChanged: (v) {
                setState(() => weight = v);
    provider.updateWeight(v.toString());
    },

            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}
