class WorkoutModel {
  final String id;
  final String name;
  final String muscle;
  final String imageUrl;
  final String description;
  final String reps;
  final String sets;
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
      reps: data['reps']?.toString() ?? '',
      sets: data['sets']?.toString() ?? '',
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
