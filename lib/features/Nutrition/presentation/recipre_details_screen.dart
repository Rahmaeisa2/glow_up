import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/recipe_model.dart';
import '../widget/clipper.dart';


class RecipreDetailsScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipreDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
           children: [
             Stack(
               clipBehavior: Clip.none,
               children: [
                 ClipPath(
                   clipper: BottomHalfCircleClipper(),
                   child: Container(
                     
                     height: 300,
                     width: double.infinity,
                     color: Colors.indigo[300],
                   ),
                 ),

                 SafeArea(
                   child: Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Align(
                       alignment: Alignment.topLeft,
                       child: IconButton(
                         focusColor: Colors.grey,
                         icon: Icon(Icons.arrow_back_outlined,

                             color: Colors.white),
                         onPressed: () => Navigator.maybePop(context),
                       ),
                     ),
                   ),
                 ),

                 Positioned(
                   left: 0,
                   right: 0,
                   bottom: -35,
                   child: Center(
                     child: ClipOval(
                       child: SizedBox(
                         width: 240,
                         height: 240,
                         child: CachedNetworkImage(
                           imageUrl: recipe.imageUrl.trim(),
                           placeholder: (context, url) => const Center(
                             child: CircularProgressIndicator(

                             ),
                           ),
                           errorWidget: (context, url, error) => const Icon(Icons.error),
                           fit: BoxFit.cover,
                           width: double.infinity,
                           height: 140,
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             )
,
             SizedBox(height: 50,),

             Padding(
               padding: const EdgeInsets.symmetric(
                 horizontal: 23,vertical: 14
               ),
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(recipe.name , style: GoogleFonts.aDLaMDisplay(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      ),

                    ),
                   SizedBox(height: 9,),
                   ...recipe.steps.map((step) {
                       return  Text(
                         textAlign: TextAlign.center,
                       step,
                       style: GoogleFonts.aDLaMDisplay(
                       textStyle: const TextStyle(
                       fontSize: 17,
                       color: Colors.black,
                       ),
                       ));
                       }
                   ) ,
                    Divider(
                      color: Colors.indigo[400],
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNutritionCard("${recipe.carbs} g", "Carbs"),
                        _buildNutritionCard("${recipe.calories} g", "Calories"),
                        _buildNutritionCard("${recipe.fats} g", "Fats"),
                        _buildNutritionCard("${recipe.protein} g", "Protein"),

                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Divider(
                      color: Colors.indigo[400],
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 6,
                    ),

                    Text(
                        "Ingredients:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: recipe.ingredients.map((ingredient) {
                        return Chip(
                          label: Text("${ingredient['name']} (${ingredient['quantity']})",
                            style: GoogleFonts.aDLaMDisplay(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400)),),
                          backgroundColor: Colors.grey[200],
                        );
                      }).toList(),
                    )



                  ]),
               ))






           ],
         ),
      ),
    );
  }
}

Widget _buildNutritionCard(String value, String title) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 5),
      Text(
        title,
        style: TextStyle(fontSize: 15, color: Colors.black ,
        fontWeight: FontWeight.w600),
      ),
    ],
  );
}
