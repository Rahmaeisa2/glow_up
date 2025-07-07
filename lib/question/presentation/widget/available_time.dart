import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theming/app_color.dart';
class AvailableTime extends StatefulWidget {
  const AvailableTime({super.key});

  @override
  State<AvailableTime> createState() => _AvailableTimeState();
}
class _AvailableTimeState extends State<AvailableTime> {
  String? selectedTime;

  final List<Map<String, dynamic>> time =[
    {"emoji" : "⏱" , "title": "Less than 15 min"},
    {"emoji" : " 🕒 " , "title": " 15-30 min "},
    {"emoji" : "⏰ " , "title": "30-60 min "},
    {"emoji" : " 🧭 " , "title": " More than 1 hour "},


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 29,
            vertical: 50,
          ),
          child: Column(
            children: [
              Text("How much time can you give daily?",
            style: GoogleFonts.aDLaMDisplay(
              textStyle: const TextStyle(
                  color: ColorsApp.p,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
              ),
              ),
              ),
              SizedBox(
                height: 42,
              ),
              ...time.map(((time){
                bool isSelected = selectedTime == time["title"];
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedTime = time["title"];

                    });

                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.indigo[100] : Colors.grey[100],
                        border: Border.all(
                          color: isSelected ? Colors.indigo : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),


                    ),
                    child: Row(
                      children: [
                        Text(time["emoji"],
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(time["title"],
                            style: GoogleFonts.aDLaMDisplay(
                                textStyle:  TextStyle(
                                  color: ColorsApp.p,
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,)))
                      ],
                    ),

                  ),

                );

      })).toList(),

            ],
          ),
        ),
      ),
    );
  }
}

