import 'package:flutter/material.dart';
import 'package:glow_up_app/features/Home/Model/recommendation_video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/routes/app_route.dart';
class VideoCard extends StatelessWidget {
  final RecommendedVideoModel video;
  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(video.videoUrl) ?? '';

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: 200,
        child:  InkWell(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.videoDetails,
                arguments: video);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 120,
                child: videoId.isNotEmpty
                    ? YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                        isLive: false
                    ),
                  ),
                  showVideoProgressIndicator: true,

                )
                    : const Icon(Icons.error),
              ),const SizedBox(height: 8),
              Text(
                video.title.isNotEmpty ? video.title : 'Untitled',
                style: const TextStyle(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
