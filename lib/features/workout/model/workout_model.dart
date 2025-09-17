class WorkoutModel {
  final String id;
  final String name;
  final String muscle;
  final String imageUrl;
  final String description;
  final int sets;
  final int reps;
  final int calories;
  final int duration;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.muscle,
    required this.imageUrl,
    required this.description,
    required this.sets,
    required this.reps,
    required this.calories,
    required this.duration,
  });

  factory WorkoutModel.fromMap(Map<String, dynamic> data, String documentId) {
    return WorkoutModel(
      id: documentId,
      name: data['name'] ?? '',
      muscle: data['muscle'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      sets: data['sets'] ?? 0,
      reps: data['reps'] ?? 0,
      calories: data['calories'] ?? 0,
      duration: data['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'muscle': muscle,
      'imageUrl': imageUrl,
      'description': description,
      'sets': sets,
      'reps': reps,
      'calories': calories,
      'duration': duration,
    };
  }
}
