// import '../Custom%20Widgets/loadImage.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'Custom.dart';
import 'loadImage.dart';
import '../Route/route.dart' as route;
// import 'package:flutter_pdfview/flutter_pdfview.dart';

class FileUploadContainer extends StatelessWidget {
  final String? chequeLeaf;
  final String? incomeImage;
  final String? signImage;
  final String? panImage;
  final Uint8List? chequeLeafBytes;
  final Uint8List? incomeImageBytes;
  final Uint8List? signImageBytes;
  final Uint8List? panImageBytes;
  const FileUploadContainer(
      {super.key,
      required this.chequeLeaf,
      required this.incomeImage,
      required this.signImage,
      required this.panImage,
      this.chequeLeafBytes,
      this.incomeImageBytes,
      this.signImageBytes,
      this.panImageBytes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFileUpload(
          title1: 'Copy of Cancel cheque/Statement',
          content1: chequeLeaf,
          contentBytes1: chequeLeafBytes,
          title2: 'Signature',
          content2: signImage,
          contentBytes2: signImageBytes,
        ),
        const SizedBox(
          height: 15.0,
        ),
        CustomFileUpload(
          title1: 'Income Proof',
          title2: 'Copy of PAN',
          content1: incomeImage,
          content2: panImage,
          contentBytes1: incomeImageBytes,
          contentBytes2: panImageBytes,
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}

class CustomFileUpload extends StatelessWidget {
  final String title1;
  final content1;
  final String title2;
  final content2;
  final Uint8List? contentBytes1;
  final Uint8List? contentBytes2;
  const CustomFileUpload(
      {super.key,
      required this.title1,
      this.content1,
      required this.title2,
      this.content2,
      required this.contentBytes1,
      required this.contentBytes2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: contentBytes1 != null,
            child: Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTitleText(
                    title: title1,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Expanded(child: SizedBox()),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
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
                    child: content1 == ""
                        ? Container()
                        : getContentWidget(content1, contentBytes1, title1),
                  )
                ],
              ),
            ),
          ),
          Visibility(
              visible: contentBytes1 != null,
              child: Expanded(flex: 1, child: SizedBox())),
          Expanded(
            flex: 4,
            child: contentBytes2 == null
                ? SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTitleText(
                        title: title2,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      // Expanded(child: SizedBox()),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
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
                          child: content2 == ""
                              ? Container()
                              : getContentWidget(
                                  content2, contentBytes2, title2))
                    ],
                  ),
          ),
          Visibility(
              visible: contentBytes1 == null,
              child: Expanded(flex: 1, child: SizedBox())),
          Visibility(
              visible: contentBytes1 == null,
              child: Expanded(flex: 4, child: SizedBox()))
        ],
      ),
    );
  }
}

Widget getContentWidget(content, bytes, title) {
  if (content is String && content.toLowerCase().endsWith('.pdf')) {
    return PdfViewerWithName(
      pdfPath: content,
      id: bytes,
      title: title,
    );
  } else if (content is String) {
    return LoadImage(
      data: bytes,
      fileTitle: title,
      fileName: content,
    );
  } else {
    return const Text('Unsupported file type');
  }
}

class PdfViewerWithName extends StatelessWidget {
  final String pdfPath;
  final Uint8List id;
  final String title;

  const PdfViewerWithName({
    Key? key,
    required this.pdfPath,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route.previewPdf,
          arguments: {"title": title, "data": id, "fileName": pdfPath}),
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your PDF icon here
            const Icon(Icons.picture_as_pdf, size: 48.0, color: Colors.red),

            const SizedBox(height: 10.0),

            // Display the PDF name
            Flexible(
              child: Text(
                getFileNameFromPath(pdfPath),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),

            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  String getFileNameFromPath(String filePath) {
    List<String> pathParts = filePath.split('/');
    return pathParts.last;
  }
}
