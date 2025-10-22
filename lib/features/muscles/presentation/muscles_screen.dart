import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_up_app/core/routes/app_route.dart';
import 'package:google_fonts/google_fonts.dart';
class MusclesScreen extends StatefulWidget {
  final List<Map<String, String>> muscles = [
    {"name": "Chest", "imageUrl": "https://i.pinimg.com/736x/3e/b7/5a/3eb75abc34ad790a6efb80685cd8bd4f.jpg"},
    {"name": "Back", "imageUrl": "https://i.pinimg.com/736x/cd/06/ff/cd06ffc1151de5589479d19842dfc436.jpg"},
    {"name": "Legs", "imageUrl": "https://i.pinimg.com/736x/f7/63/1a/f7631ae1e74a699f3d245f096375fe77.jpg"},
    {"name": "Arms", "imageUrl": "https://i.pinimg.com/1200x/f0/54/58/f054584703c1e0819985c85b5704d657.jpg"},
    {"name": "Shoulders", "imageUrl": "https://i.pinimg.com/1200x/3b/0c/94/3b0c9446b29653447fd9a6d7d0778733.jpg"},
    {"name": "Abs", "imageUrl": "https://i.pinimg.com/1200x/4a/e1/94/4ae194279b68e2bd6d82d1085b1d5cb8.jpg"},
  ];
   MusclesScreen({super.key});

  @override
  State<MusclesScreen> createState() => _MusclesScreenState();
}

class _MusclesScreenState extends State<MusclesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,  backgroundColor: Theme.of(context).colorScheme.surface,


        centerTitle: true,
        title: Text("Muscles",style: Theme.of(context).textTheme.displaySmall),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,

      ),
        itemCount: widget.muscles.length,
        itemBuilder: (context, index){
        final muscle = widget.muscles[index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.workout,
              arguments: muscle['name']
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10 ,
              horizontal: 7,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceBright,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15
                  ),
                  child: Column(
                    children: [
                      Image.network(muscle['imageUrl'] ?? '',
                        fit: BoxFit.cover,
                        height: 120.h,
                      ),
                      SizedBox(height: 14.h,),
                      Text(muscle['name'] ?? "",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
color: Theme.of(context).colorScheme.primary
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        }
      )
    ) ;
  }
}
