import 'dart:io';
import 'package:ekyc/API%20call/api_call.dart';
import 'package:pdfx/pdfx.dart';
import 'package:ekyc/Custom%20Widgets/custom_snackBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:device_info_plus/device_info_plus.dart';

// String name = await SmsAutoFill().getAppSignature;
// List a = name.split(":");
// name1 = a[a.length - 1];

// void checkPermissions(source) async {
//   if (int.parse(version!) >= 13) {
//     if (await Permission.camera.request().isGranted
//         //awdfasd
//         &&
//         await Permission.photos.request().isGranted) {
//       PermissionStatus cameraStatus = await Permission.camera.status;
//       PermissionStatus phoneStatus = await Permission.photos.status;
//       print('Camera Permission Status: $cameraStatus');
//       print('Phone Permission Status: $phoneStatus');
//       captureImage(source);
//     } else {
//       // Permissions not granted, handle accordingly
//     }
//   } else {
//     if (await Permission.camera.request().isGranted
//             //&& await Permission.storage.request().isGranted
//             &&
//             await Permission.storage.request().isGranted
//         //afs
//         ) {
//       PermissionStatus cameraStatus = await Permission.camera.status;
//       PermissionStatus storageStatus = await Permission.storage.status;
//       print('Camera Permission Status: $cameraStatus');
//       print('Storage Permission Status: $storageStatus');
//       captureImage(source);
//     } else {
//       // Permissions not granted, handle accordingly
//     }
//   }
// }

pickFileBottomSheet(context, func) {
  Future<void> captureImage(source) async {
    String? path;

    try {
      switch (source) {
        case "camera":
          var image = await ImagePicker().pickImage(source: ImageSource.camera);
          image != null ? path = image.path : null;
          break;
        case "gallery":
          var image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          image != null ? path = image.path : null;
          break;
        case "files":
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'png', 'pdf'],
            allowMultiple: false,
          );
          result != null ? path = result.files.single.path : null;
          break;
      }
      if (path != null) {
        if (path.endsWith(".pdf")) {
          var document = await PdfDocument.openFile(path);
          // print(document.pagesCount);
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        File file = File(path);
        int size = await file.length();
        print(size / (1024 * 1024));
        size > (2 * 1024 * 1024)
            ? showSnackbar(
                context, "file size must be less then 2MB", Colors.red)
            : func(path);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
      print(e.toString().contains("PdfRendererException"));
      String message = e.toString().contains("PdfRendererException")
          ? "PDF is protected please upload another file"
          : e.toString();
      !e.toString().contains("denied")
          ? showSnackbar(context, message, Colors.red)
          : null;
    }
    // setState(() {});
  }

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0))),
    builder: (context) {
      return SizedBox(
        height: 110,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 10.0),
              InkWell(
                  onTap: () {
                    captureImage("camera");
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 40.0,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  )),
              const SizedBox(width: 10.0),
              InkWell(
                  onTap: () {
                    captureImage("gallery");
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        size: 40.0,
                      ),
                      Text(
                        'gallery',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  )),
              const SizedBox(width: 10.0),
              InkWell(
                  onTap: () {
                    captureImage("files");
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 40.0,
                      ),
                      Text(
                        'files',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
    },
  );
}
