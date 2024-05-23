import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../API call/api_call.dart';
import "../Route/route.dart" as route;

class LoadImage extends StatefulWidget {
  final String fileTitle;
  final data;
  final String? fileName;
  const LoadImage(
      {super.key, required this.fileTitle, required this.data, this.fileName});

  @override
  State<LoadImage> createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {
  @override
  void initState() {
    widget.data is String ? fetchImage() : isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
    super.initState();
  }

  List? file;
  bool isLoading = true;
  fetchImage() async {
    file = await fetchFile(context: context, id: widget.data, list: true);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : widget.data is Uint8List
            ? GestureDetector(
                child: Image.memory(
                  widget.data,
                ),
                onTap: () {
                  // imageAlert(context, snapshot.data!);

                  Navigator.pushNamed(context, route.previewImage, arguments: {
                    "title": widget.fileTitle,
                    "data": widget.data,
                    "fileName": widget.fileName
                  });
                },
              )
            : file != null && file!.isNotEmpty
                ? GestureDetector(
                    child: Image.memory(
                      file![1],
                    ),
                    onTap: () {
                      // imageAlert(context, snapshot.data!);

                      Navigator.pushNamed(context, route.previewImage,
                          arguments: {
                            "title": widget.fileTitle,
                            "data": file![1],
                            "fileName": file![0]
                          });
                    },
                  )
                : Center(
                    child: Text("no image"),
                  );
    //  FutureBuilder(
    //     //9518 pdf 9499 png
    //     future: fetchFile(context: context, id: widget.data, list: true),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Container(
    //             alignment: Alignment.center,
    //             child: const CircularProgressIndicator());
    //       } else if (snapshot.hasError) {
    //         return Text('Error: ${snapshot.error}');
    //       } else if (!snapshot.hasData) {
    //         return Text('No image data');
    //       } else {
    //         List file = snapshot.data! as List;
    //         return GestureDetector(
    //           onTap: () {
    //             // imageAlert(context, snapshot.data!);
    //             Navigator.pushNamed(context, route.previewImage,
    //                 arguments: {
    //                   "title": widget.fileTitle,
    //                   "data": file[1],
    //                   "fileName": file[0]
    //                 });
    //           },
    //           child: Image.memory(
    //             file[1],
    //           ),
    //         );
    //       }
    //     },
    //   );
  }
}
