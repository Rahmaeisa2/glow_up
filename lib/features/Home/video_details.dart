import 'package:flutter/material.dart';
import 'package:glow_up_app/features/Home/Model/recommendation_video_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoDetails extends StatefulWidget {
  final RecommendedVideoModel video;
  const VideoDetails({super.key, required this.video});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late YoutubePlayerController _controller;
  @override
  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.video.videoUrl)??"";
    _controller = YoutubePlayerController(initialVideoId: videoId,
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: false
    ));
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.video.title)),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14
          ),
          child: Column(
            children: [
              YoutubePlayer(
                thumbnail: Container(
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(13),

                  ),
                ),
                actionsPadding: EdgeInsetsGeometry.symmetric(horizontal: 12,
                vertical: 10),
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  print('Player is ready for video: ${widget.video.title}');
                },
                onEnded: (metaData) {
                  _controller.pause();
                },
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   Text('${widget.video.title} ',
                   style:  GoogleFonts.aDLaMDisplay(
               textStyle: const TextStyle(
               fontSize: 22,
                 fontWeight: FontWeight.w400,
               ),),),
                   SizedBox(
                     height: 10,
                   ),
                  Text('${widget.video.description}'
                   , style: GoogleFonts.aDLaMDisplay(
                    textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(' Level : ${widget.video.level} ',
                      style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),)),

                 ],
               ),
             )
            ],
          ),
        ));
  }
}
