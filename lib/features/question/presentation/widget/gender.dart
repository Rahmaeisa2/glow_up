import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/theming/app_color.dart';
import '../../../../core/widget/user-answers.dart';
import '../../provider/user_onboarding_provider.dart';

class GenderSelectionWidget extends StatefulWidget {

  GenderSelectionWidget({super.key});

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  final ValueNotifier<String?> gender = ValueNotifier(null);

  TextEditingController height = TextEditingController();

bool? isMale =null;
bool isSelected =false ;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserOnboardingProvider>(context);

    return GestureDetector(
        onTap: () {
      setState(() {
        isMale = null;
      });
    },
     child:  Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,
        vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("What's your gender?",
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color:
                 Theme.of(context).colorScheme.primary

                  )
              ),
              SizedBox(
                height: 30,
              ),
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
           onTap: () {
    setState(() {
    isMale = true;
    });
    provider.updateGender("Male");
    },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                    color: isSelected? Theme.of(context).colorScheme.onPrimary: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(12),
                     border: Border.all(
                        color: (isMale == true) ? Theme.of(context).colorScheme.primary: Colors.transparent,
                       width: 3,
                     ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.male, size: 60, color:Theme.of(context).colorScheme.primary),
                        Text("Male",
                            style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,

                                color:
                            Theme.of(context).colorScheme.primary)
                        )
                      ],
                    ),
                  ),
                ),
              ),
          
              SizedBox(width: 10),
          
              Expanded(
                child: GestureDetector(
                  onTap: () {
                      setState(() {
                        isMale = false;
                      });
                      provider.updateGender("Female");

                  },

                  child: Container(

                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: isSelected? Theme.of(context).colorScheme.onPrimary: Theme.of(context).colorScheme.outline,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (isMale == false) ? Theme.of(context).colorScheme.primary : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.female, size: 60, color: Theme.of(context).colorScheme.primary),
                        Text("Female",   style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color:
                            Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],

        ),
      ),)
    );
  }
}
