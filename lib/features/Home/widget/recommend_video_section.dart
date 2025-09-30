import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glow_up_app/features/Home/widget/video_card.dart';

import '../Model/recommendation_video_model.dart';
class RecommendVideoSection extends StatelessWidget {
  final String userTarget;
  const RecommendVideoSection({super.key, required this.userTarget});
  RecommendedVideoModel _videoFromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecommendedVideoModel(
      id: doc.id,
      videoUrl: data['videoUrl'] ?? '',
      title: data['title'] ?? '',
      target: data['target']?.toString().toLowerCase() ?? '',
      type: data['type']?.toString().toLowerCase() ?? '',
      level: data['level']?.toString().toLowerCase() ?? '',
      duration: data['duration'] ?? '',
      description: data['description'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot>? videoStream;
    try {
      videoStream = FirebaseFirestore.instance
          .collection('recommendation')
          .where('target', isEqualTo: userTarget.toLowerCase())
          .snapshots();
      print('Stream created for target: $userTarget');
    } catch (e) {
      print('Error creating videoStream: $e');
      videoStream = Stream.error('Query Error: $e');
    }
    return  SizedBox(
        height: 160,
        child: StreamBuilder(stream: videoStream,
            builder: (context, snapshot) {
              // Debugging prints
              print('Stream state: ${snapshot.connectionState}');

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print('Stream error: ${snapshot.error}');
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                print('No videos found for target: $userTarget');
                return const Center(child: Text('No recommended videos found'));
              }

              print('Number of videos found: ${snapshot.data!.docs.length}');

              final videos = snapshot.data!.docs
                  .map((doc) => _videoFromSnapshot(doc))
                  .where((v) => v.target.isNotEmpty && v.type.isNotEmpty)
                  .toList();

              print('Videos before filter: ${videos.length}');

              final videosToShow = userTarget == 'lose_weight'
                  ? videos
                  .where((v) =>
              v.type == 'cardio' ||
                  v.type == 'upper' ||
                  v.type == ''
                      '')
                  .take(2)
                  .toList(): videos
                  .where((v) => v.type == 'upper' || v.type == 'lower')
                  .take(3)
                  .toList();

              print('Videos after filter: ${videosToShow.length}');
              if (videosToShow.isEmpty) {
                print('No videos after filtering for target: $userTarget');
                return const Center(child: Text('No matching videos found'));
              }
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videosToShow.length,
                  itemBuilder: (context, index) => VideoCard(video: videosToShow[index]));
                  }
                  ));
}}
