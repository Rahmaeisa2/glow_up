import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theming/app_color.dart';
class GenderSelectionWidget extends StatefulWidget {

  GenderSelectionWidget({super.key});

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  final ValueNotifier<String?> gender = ValueNotifier(null);

  TextEditingController height = TextEditingController();

bool? isMale =null;
  @override
  Widget build(BuildContext context) {
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
                  style: GoogleFonts.aDLaMDisplay(
                    textStyle: const TextStyle(
                        color: ColorsApp.p,
                        fontSize: 26,
                        fontWeight: FontWeight.w400
                    ),
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
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                     border: Border.all(
                        color: (isMale == true) ? Colors.indigo: Colors.transparent,
                       width: 3,
                     ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.male, size: 60, color:ColorsApp.p),
                        Text("Male", style: GoogleFonts.aDLaMDisplay(
                        textStyle: const TextStyle(
                        color: ColorsApp.p,
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        ),
                  )),
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
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (isMale == false) ? Colors.indigo : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.female, size: 60, color: ColorsApp.p),
                        Text("Female",  style: GoogleFonts.aDLaMDisplay(
                          textStyle: const TextStyle(
                              color: ColorsApp.p,
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                        )),
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
