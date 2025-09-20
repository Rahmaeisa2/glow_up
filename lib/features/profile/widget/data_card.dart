import 'package:flutter/material.dart';
import 'package:glow_up_app/features/profile/widget/state_item.dart';
import 'package:google_fonts/google_fonts.dart';
class DataCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const DataCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text(userData['onboarding']?['name']??'' ,
                style: GoogleFonts.aDLaMDisplay(
                  textStyle:  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,),)),
          ),
          SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.
              symmetric(
                horizontal: 12
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        StateItem(label: "Age", value: '${(userData['onboarding']?['age'] as num).round()??''}y.o'),
                        SizedBox(width: 12,),
                        StateItem(label: "Height", value: '${(userData['onboarding']?['weight_kg'] as num).round()??''}kg'),
                        SizedBox(width: 12,),

                        StateItem(label: "Age", value: '${(userData['onboarding']?['height_cm'] as num).round()??''}cm'),
                      ],


                          ),
              ),
            ),
        ]);
  }
}
