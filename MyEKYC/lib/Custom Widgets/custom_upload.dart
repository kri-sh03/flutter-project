import 'dart:io';

import 'package:flutter/material.dart';
import "../Route/route.dart" as route;

class CustomUpload extends StatefulWidget {
  final String title;
  final String subTitle;
  final dropDown;
  final String? fileName;
  final file;
  final onTap;
  final String fileType;
  const CustomUpload({
    super.key,
    required this.title,
    required this.subTitle,
    this.dropDown,
    required this.fileName,
    required this.file,
    required this.onTap,
    required this.fileType,
  });

  @override
  State<CustomUpload> createState() => _CustomUploadState();
}

class _CustomUploadState extends State<CustomUpload> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: const Color.fromRGBO(9, 101, 218, 1),
        ),
        borderRadius: BorderRadius.circular(7.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.subTitle,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              if (MediaQuery.of(context).size.width >= 350) ...[
                ElevatedButton(
                  style: ButtonStyle(
                    // fixedSize: const MaterialStatePropertyAll(Size(115, 40)),
                    textStyle: const MaterialStatePropertyAll(
                      TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.3,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      widget.file != null && widget.file.toString().isNotEmpty
                          ? Colors.green
                          : Color.fromRGBO(190, 215, 246, 1),
                    ),
                  ),
                  onPressed: widget.onTap,
                  child:
                      //  fileName != null
                      //     ? Text(
                      //         fileName!,
                      //         style: TextStyle(
                      //             color: Theme.of(context)
                      //                 .textTheme
                      //                 .bodyMedium!
                      //                 .color),
                      //       )
                      //     :
                      Row(
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: widget.file != null &&
                                widget.file.toString().isNotEmpty
                            ? Colors.white
                            : Colors.black,
                        size: 20.0,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        widget.file != null && widget.file.toString().isNotEmpty
                            ? 'Reupload'
                            : 'Upload',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: widget.file != null &&
                                    widget.file.toString().isNotEmpty
                                ? Colors.white
                                : Color.fromARGB(255, 70, 68, 68),
                            fontSize: 15.0
                            // Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium!
                            //     .color,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          if (MediaQuery.of(context).size.width < 350) ...[
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    // fixedSize: const MaterialStatePropertyAll(Size(150, 40)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.3,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      Color.fromRGBO(190, 215, 246, 1),
                    ),
                  ),
                  onPressed: () {},
                  child:
                      //  fileName != null
                      // ? Text(
                      //     fileName!,
                      //     style: TextStyle(
                      //         color: Theme.of(context)
                      //             .textTheme
                      //             .bodyMedium!
                      //             .color),
                      //   )
                      // :
                      Row(
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        color: Colors.black,
                      ),
                      Text(
                        'Upload',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          if (widget.dropDown != null) ...[
            SizedBox(height: 10.0),
            widget.dropDown
          ],

          if (widget.file != null && widget.file.toString().isNotEmpty) ...[
            const SizedBox(height: 10.0),
            InkWell(
              child: Text(
                "preview ${widget.fileName!} file",
                style: TextStyle(color: Color.fromRGBO(50, 169, 220, 1)),
              ),
              onTap: () async {
                print(widget.file);
                Navigator.pushNamed(
                    context,
                    widget.file is File
                        ? widget.file!.path.toLowerCase().endsWith(".pdf")
                            ? route.previewPdf
                            : route.previewImage
                        : widget.fileType.toLowerCase().endsWith("pdf")
                            ? route.previewPdf
                            : route.previewImage,
                    arguments: widget.file is File
                        ? {
                            "title": widget.fileName,
                            "data": await widget.file.readAsBytes(),
                            "fileName": widget.file!.path
                          }
                        : {
                            "title": widget.fileName,
                            "data": widget.file,
                            "fileName": "${widget.fileName}.${widget.fileType}"
                          });
              },
            )
          ]
          // Row(
          //   children: [
          //     const SizedBox(
          //       width: 30,
          //     ),
          //     Expanded(
          //       child: dropDown ?? const SizedBox(),
          //     ),
          //     const SizedBox(
          //       width: 30,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
