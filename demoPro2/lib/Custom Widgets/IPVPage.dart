// import '../Custom%20Widgets/loadImage.dart';
// import '../Custom%20Widgets/video_player.dart';
import 'package:ekyc/Custom%20Widgets/FileUpload.dart';
import 'package:flutter/material.dart';

import '../Model/route_model.dart';
import 'Custom.dart';
import 'error_message.dart';
import 'loadImage.dart';
import 'video_player.dart';

// import '../Expansion/Custom.dart';

class IPVPage extends StatefulWidget {
  final String imageId;
  final String videoId;
  final String otp;
  final RouteModel? routeDetails;
  const IPVPage(
      {super.key,
      required this.imageId,
      required this.videoId,
      this.routeDetails,
      required this.otp});

  @override
  State<IPVPage> createState() => _IPVPageState();
}

class _IPVPageState extends State<IPVPage> {
  @override
  void dispose() {
    // print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStyledContainer(
      child: Column(
        children: [
          ErrorMessageContainer(routeDetails: widget.routeDetails),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    const CustomTitleText(
                      title: 'Selfie Image',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        // width: 109.20,
                        height: 145.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3.0,
                              blurRadius: 5.0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: widget.imageId == ""
                            ? Container()
                            : LoadImage(
                                data: widget.imageId,
                                fileTitle: "ipvImage",
                              ))
                  ],
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 4,
                child: widget.videoId.isEmpty
                    ? SizedBox()
                    : Column(
                        children: [
                          const CustomTitleText(
                            title: 'Selfie Video',
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                              // width: 109.20,
                              height: 145.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3.0,
                                    blurRadius: 5.0,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                // borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: VideoPlayerInReview(
                                data: widget.videoId,
                                otp: widget.otp,
                              ))
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
