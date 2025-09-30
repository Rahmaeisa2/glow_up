import 'package:flutter/material.dart';

import '../../../core/services/workout_service.dart';
import '../model/workout_model.dart';


class WorkoutProvider extends ChangeNotifier {
  final WorkoutService _service = WorkoutService();
  String errorMessage = '';
  Map<String, List<WorkoutModel>> workoutsByMuscle = {};
  bool isLoading = false;

  Future<void> loadWorkouts(String muscleName) async {
    if (workoutsByMuscle.containsKey(muscleName) &&
        workoutsByMuscle[muscleName]!.isNotEmpty)
      return; // الكاش لكل muscle
    isLoading = true;
    notifyListeners();

    try {
      final stream = _service.getWorkout(muscleName);
      stream.listen((data) {
        workoutsByMuscle[muscleName] = data;
        notifyListeners();
      });
    } catch (e) {
      print("Error loading workouts: $e");
    }

    isLoading = false;
    notifyListeners();
  }
  List<WorkoutModel> getWorkoutsByMuscle(String muscle) {
    return workoutsByMuscle[muscle] ?? [];
  }
}
