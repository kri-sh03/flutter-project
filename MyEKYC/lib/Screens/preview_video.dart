import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../Service/download_file.dart';

class PreviewVideo extends StatefulWidget {
  final File file;
  const PreviewVideo({super.key, required this.file});

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
  VideoPlayerController? _videoController;

  // ChewieController? _chewieController;
  bool isPlay = false;
  bool downloadButtonEnable = false;
  bool fullScreen = false;
  String fileName = '';

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    List l = widget.file.path.split("/");
    fileName = l[l.length - 1];
    getVideo();
  }

  getVideo() async {
    _videoController = VideoPlayerController.file(
      widget.file,
    );
    await _videoController!.initialize();
    await _videoController!.setLooping(true);
    await _videoController!.play();
    if (mounted) {
      isPlay = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(0, 71, 255, 0.81)));
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _videoController == null || !_videoController!.value.isInitialized
          ? Container(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : InkWell(
              onTap: () {
                if (isPlay) {
                  _videoController!.pause();
                  isPlay = false;
                } else {
                  _videoController!.play();
                  isPlay = true;
                }
                setState(() {});
              },
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 1,
                      // width: MediaQuery.of(context).size.width * 0.9,
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      )),
                  Visibility(
                    visible: !isPlay,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.06,
                      color:
                          Colors.transparent, // Colors.grey.withOpacity(0.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          Text(
                            'Preview',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                downloadFile(
                                    "ipvVideo",
                                    widget.file.readAsBytesSync(),
                                    fileName,
                                    context);
                              },
                              icon: const Icon(
                                Icons.download,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isPlay,
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.99,
                      width: double.infinity,
                      child: Icon(
                        isPlay ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
