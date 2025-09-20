import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  final CollectionReference _workoutCollection =
      FirebaseFirestore.instance.collection('workout');

  Future<void> addRecipeIfNotExists (Map<String ,dynamic> workout) async{
    try{
      final doc = await _workoutCollection.doc(workout['id']).get();
      if(!doc.exists){
        await _workoutCollection.doc(workout['id']).set(workout);
        print("workout added : ${workout['name']}");
      }

    } catch (e) {
      print("Failed to add recipe: $e");
    }
  }
  Future<void> addWorkoutsIfNotExists (List<Map<String,dynamic>> workouts)async{
for(var workout in workouts){
  await addRecipeIfNotExists(workout);

}
  }
}