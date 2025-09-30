class RecommendedVideoModel {
  final String id;
  final String videoUrl;
  final String title;
  final String target;
  final String type;
  final String level;
  final String duration;
  final String description;

  RecommendedVideoModel({
    required this.id,
    required this.videoUrl,
    required this.title,
    required this.target,
    required this.type,
    required this.level,
    required this.duration,
    required this.description,
  });

  factory RecommendedVideoModel.fromMap(Map<String, dynamic> data, String id) {
    return RecommendedVideoModel(
      id: id,
      videoUrl: data['videoUrl'] ?? '',
      title: data['title'] ?? '',
      target: data['target']?.toString().toLowerCase() ?? '',
      type: data['type']?.toString().toLowerCase() ?? '',
      level: data['level']?.toString().toLowerCase() ?? '',
      duration: data['duration'] ?? '',
      description: data['description'] ?? '',
    );
  }
}