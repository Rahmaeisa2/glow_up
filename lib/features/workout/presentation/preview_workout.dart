import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_route.dart';
import '../model/workout_model.dart';

class PreviewWorkout extends StatelessWidget {
  final String name;
  final String muscle;
  final String imagePath;

  const PreviewWorkout({
    super.key,
    required this.name,
    required this.muscle,
    required this.imagePath, required this.workout,
  });
  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,

              ),
            ),
          ),
           SizedBox(height: 17.h),
          Text(name,  style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary
          )),
          Text(muscle,  style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary
          )),
          const SizedBox(height: 20),
          Container(
            height: 46.h,
            width: 90.w,
            child: ElevatedButton(

              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.workoutDetails ,
                    arguments: workout
                );
              },
              child: const Text("Start"),
            ),
          ),
        ],
      ),
    );
  }
}
