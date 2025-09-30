import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/workout_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: workout.imageUrl.trim(),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 120,
                )
                ,
                const SizedBox(height: 10),
                Text(
                  workout.name,
                  style: GoogleFonts.aDLaMDisplay(
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${workout.sets}×${workout.reps}",
                        style: const TextStyle(fontSize: 17 ,
                        fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: const Icon(Icons.arrow_forward_ios_sharp),
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
