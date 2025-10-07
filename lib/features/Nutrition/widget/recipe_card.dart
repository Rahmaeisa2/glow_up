import 'package:flutter/material.dart';
import 'package:glow_up_app/features/workout/model/workout_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onTap;
   RecipeCard({super.key, required this.recipe, required this.onTap, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12
            ),
            child: Column(
              children: [
                CachedNetworkImage(
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
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(recipe.name,
                  style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                      fontSize: 15,))),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${recipe.calories} kcal", style: GoogleFonts.aDLaMDisplay(
                          textStyle: const TextStyle(
                            fontSize: 13,)),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          fontWeight: FontWeight.w600,
                          shadows: [
                          BoxShadow(color: Colors.grey.shade300,blurRadius: 4)
                        ],),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
