import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/workout/model/workout_model.dart';

class WorkoutService {
  late final String muscleName;

  final CollectionReference _workoutCollection =
  FirebaseFirestore.instance.collection('workout');


  Stream<List<WorkoutModel>> getWorkout(String muscleName) {
    try {
      return _workoutCollection
          .where('muscle', isEqualTo: muscleName)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => WorkoutModel.fromMap(
          doc.data() as Map<String, dynamic>, doc.id))
          .toList());
    } catch (e) {
      return Stream.error(e); // بيرجع ستريم فيه error
    }
  }

    Future<void> addWorkoutIfNotExists(Map<String, dynamic> workout) async {
    try {
      final doc = await _workoutCollection.doc(workout['id']).get();
      if (!doc.exists) {
        await _workoutCollection.doc(workout['id']).set(workout);
        print("Workout added: ${workout['name']}");
      }
    } catch (e) {
      print("Failed to add workout: $e");
    }
  }

  Future<void> addWorkoutsIfNotExists(List<Map<String, dynamic>> workouts) async {
    for (var workout in workouts) {
      await addWorkoutIfNotExists(workout);
    }
  }

  Future<void> updateWorkout(Map<String, dynamic> workout) async {
    try {
      final docRef = _workoutCollection.doc(workout['id']);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final oldData = docSnapshot.data() as Map<String, dynamic>;
      }}

       catch (e) {
      print("Failed to update workout: $e");
    }
  }


  Future<void> updateWorkouts(List<Map<String, dynamic>> workouts) async {
    for (var workout in workouts) {
      await updateWorkout(workout);
    }
  }

  Future<void> deleteAllWorkouts() async {
    final snapshot = await _workoutCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    print("All workouts deleted.");
  }
}
