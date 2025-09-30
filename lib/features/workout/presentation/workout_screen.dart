import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glow_up_app/core/routes/app_route.dart';
import 'package:glow_up_app/core/services/workout_service.dart';
import 'package:glow_up_app/features/workout/presentation/preview_workout.dart';
import 'package:provider/provider.dart';
import '../data/workouts_data.dart';
import '../model/workout_model.dart';
import '../provider/workout_provider.dart';
import '../widget/workout_card.dart';

class WorkoutScreen extends StatefulWidget {
  final String muscleName;
  const WorkoutScreen({super.key, required this.muscleName});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  @override
  void initState() {
    super.initState();

    WorkoutService().addWorkoutsIfNotExists(Workouts);
    WorkoutService().updateWorkouts(Workouts);
    Future.microtask(() {
      Provider.of<WorkoutProvider>(context, listen: false)
          .loadWorkouts(widget.muscleName);
    });

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);
    final workouts = provider.workoutsByMuscle[widget.muscleName] ?? [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.maybePop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 24,
          ),
        ),
        title: Text(
          widget.muscleName,
          style: GoogleFonts.aDLaMDisplay(
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      body:
      provider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : workouts.isEmpty
        ? const Center(child: Text("No workouts found"))
        : GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: workouts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return WorkoutCard(
          workout: workout,
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => PreviewWorkout(
                name: workout.name,
                muscle: workout.muscle,
                imagePath: workout.imageUrl,
                workout: workout,
              ),
            );
          },
        );

}
        )
        );

}}

