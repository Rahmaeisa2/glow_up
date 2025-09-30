
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/Home/Model/recommendation_video_model.dart';

class RecommendedVideoService{
final CollectionReference _recommendationWorkout = FirebaseFirestore.instance.collection('recommendation');
Stream<QuerySnapshot> getRecommendedVideosByTarget(String target) {
  print('$target');
  return _recommendationWorkout
      .where('target', isEqualTo: target.toLowerCase())
      .snapshots();
}
Future<void> addVideosNotExists(List<Map<String, dynamic>> videos) async{
  for(var video in videos){
    final exist = await
    _recommendationWorkout.where('videoUrl', isEqualTo: video['videoUrl']).get();
    if (exist.docs.isEmpty) {
      await _recommendationWorkout.add(video);
      print('Added video: ${video['title']}');
    } else {
      print('Video already exists: ${video['title']}');
    }
  }}
}

