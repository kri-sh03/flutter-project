import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

import '../API call/api_call.dart';
import '../Route/route.dart' as route;

class VideoPlayerInReview extends StatefulWidget {
  final String? fileName;
  final data;
  const VideoPlayerInReview({super.key, required this.data, this.fileName});

  @override
  State<VideoPlayerInReview> createState() => _VideoPlayerInReviewState();
}

class _VideoPlayerInReviewState extends State<VideoPlayerInReview> {
  VideoPlayerController? _videoController;
  File? tempFile;
  // ChewieController? _chewieController;
  bool isPlay = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getVideo();
  }

  getVideo() async {
    var response = widget.data is String && widget.data.toString().isNotEmpty
        ? await fetchFile(context: context, id: widget.data, list: true)
        : await widget.data;
    print("video");
    print(widget.data);
    print(response);
    if (response != null && widget.data.toString().isNotEmpty) {
      // print(
      //     response); // Replace 'assets/sample_video.mp4' with the actual path or URL of your video
      final tempDir = await getTemporaryDirectory();
      tempFile = File(
          '${tempDir.path}/${widget.data is String ? response[0] : widget.fileName}');

      await tempFile!
          .writeAsBytes(widget.data is String ? response[1] : response);
      _videoController = VideoPlayerController.file(
        tempFile!,
      );
      // _videoController = VideoPlayerController.networkUrl(Uri.parse(
      //   "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
      // ));

      // Initialize the controller and load the video
      // _controller.initialize().then((_) {
      //   // Ensure the first frame is shown after the video is initialized
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     if (mounted) {
      //       setState(() {});
      //     }
      //   });
      // });
      await _videoController!.initialize();
      await _videoController!.setLooping(true);

      // Add a listener to update the state when the video is playing
      // _controller!.addListener(() {

      // });

      // Start playing the video
      // await _videoController!.play();
      // _chewieController = ChewieController(
      //   videoPlayerController: _videoController!,
      //   aspectRatio: 16 / 9, // Adjust the aspect ratio based on your video
      //   autoPlay: true,
      //   looping: true,
      // );
    } else {
      isLoading = false;
    }
    if (mounted) {
      // isPlay = true;
      setState(() {});
    }
  }

  playVideo() async {}

  deleteTempFile() async {
    if (await tempFile?.exists() ?? false) {
      await tempFile!.delete();
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    deleteTempFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoController != null && _videoController!.value.isInitialized
        ? InkWell(
            onTap: () => Navigator.pushNamed(context, route.previewVideo,
                arguments: tempFile),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // VideoPlayer(_videoController!),
                VideoPlayer(_videoController!),
                // IconButton(
                //     onPressed: () {
                //       if (isPlay) {
                //         _videoController!.pause();
                //         isPlay = false;
                //       } else {
                //         _videoController!.play();
                //         isPlay = true;
                //       }
                //       setState(() {});
                //     },
                //     icon: Icon(
                //       isPlay ? Icons.pause : Icons.play_arrow,
                //       color: Colors.white,
                //     ))
                Icon(
                  isPlay ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                )
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: isLoading ? CircularProgressIndicator() : SizedBox());
    //     FutureBuilder(
    //   //9518 pdf 9499 png
    //   future: getVideo(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return _controller != null && _controller.value.isInitialized
    //           ? AspectRatio(
    //               aspectRatio: _controller.value.aspectRatio,
    //               child: VideoPlayer(_controller),
    //             )
    //           : Center(child: Text('Failed to load video.'));
    //     } else {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }
}
