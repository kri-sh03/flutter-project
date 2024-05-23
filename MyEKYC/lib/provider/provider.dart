import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

// class Colorchange extends ChangeNotifier {
//   Future<FilePickerResult> pick1() async {
//     FilePickerResult? f1;
//     f1 = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'jpg', 'png'],
//         allowMultiple: false);
//     notifyListeners();
//     return f1!;
//   }

//   int age = 20;
//   DateTime? selectedDate;
//   List<String> names = [];
//   String? nominee1;
//   String? nominee2;
//   String? nominee3;
//   bool hieght = false;
//   bool? wish = true;
//   changenom1name({required String name, required String relation}) {
//     nominee1 = '$name ($relation)';
//     print(nominee1);
//     age = 20;
//     names.add(name);
//     notifyListeners();
//   }

//   changenom2name({required String name, required String relation}) {
//     nominee2 = '$name ($relation)';
//     names.add(name);
//     age = 20;
//     notifyListeners();
//   }

//   changenom3name({required String name, required String relation}) {
//     nominee3 = '$name ($relation)';
//     age = 20;
//     names.add(name);
//     notifyListeners();
//   }

//   radio(bool val) {
//     wish = val;
//     age = 20;
//     notifyListeners();
//   }

//   agecheck(DateChange dc) {
//     selectedDate = dc.value;
//     print(dc.value);
//     age = DateTime.now().year - selectedDate!.year;

//     if (DateTime.now().month < selectedDate!.month ||
//         (DateTime.now().month == selectedDate!.month &&
//             DateTime.now().day < selectedDate!.day)) {
//       age--;
//     }
//     print('${age}');
//   }
// }

// class son extends ChangeNotifier {
//   double switchon3 = 0;
//   double switchon2 = 0;
//   double switchon1 = 0;
//   bool button = false;
//   change3(double vue) {
//     switchon3 = vue;
//     button = false;
//     notifyListeners();
//   }

//   change2(double vue) {
//     switchon2 = vue;
//     button = false;
//     notifyListeners();
//   }

//   change1(double vue) {
//     switchon1 = vue;
//     button = false;
//     notifyListeners();
//   }

//   changebutton(bool val, int length) {
//     button = val;
//     if (button) {
//       if (length == 2) {
//         switchon1 = 50.00;
//         switchon2 = 50.00;
//       } else if (length == 3) {
//         switchon1 = 33.33;
//         switchon2 = 33.33;
//         switchon3 = 33.33;
//       }
//     }
//     notifyListeners();
//   }
// }

class Postmap extends ChangeNotifier {
  List<Map<String, dynamic>> response = [];
  File? nFIle1;
  File? nFIle2;
  File? nFIle3;
  File? gFIle1;
  File? gFIle2;
  File? gFIle3;
  String nFIleName1 = "";
  String nFIleName2 = "";
  String nFIleName3 = "";
  String gFIleName1 = "";
  String gFIleName2 = "";
  String gFIleName3 = "";
  addmap(Map<String, dynamic> m) {
    response.add(m);
    notifyListeners();
  }

  changeResponse(List<Map<String, dynamic>> newResponse) {
    response = newResponse;
    notifyListeners();
  }

  chenageResponseToEmpty() {
    response.clear();
  }

  changenFile(String name, File? file, String fileName, bool isNominee) {
    print("file $file fileName $fileName");
    switch (name) {
      case "Nominee 1":
        isNominee ? nFIle1 = file : gFIle1 = file;
        isNominee ? nFIleName1 = fileName : gFIleName1 = fileName;
        break;
      case "Nominee 2":
        isNominee ? nFIle2 = file : gFIle2 = file;
        isNominee ? nFIleName2 = fileName : gFIleName2 = fileName;
        break;
      case "Nominee 3":
        isNominee ? nFIle3 = file : gFIle3 = file;
        isNominee ? nFIleName3 = fileName : gFIleName3 = fileName;
        break;
      default:
    }
    print(gFIle1);
    print(gFIleName1);
    notifyListeners();
  }

  getFile(String name, bool isNominee) {
    switch (name) {
      case "Nominee 1":
        return isNominee ? nFIle1 : gFIle1;
      case "Nominee 2":
        return isNominee ? nFIle2 : gFIle2;
      case "Nominee 3":
        return isNominee ? nFIle3 : gFIle3;
      default:
    }
    notifyListeners();
  }

  getFileName(String name, bool isNominee) {
    switch (name) {
      case "Nominee 1":
        return isNominee ? nFIleName1 : gFIleName1;
      case "Nominee 2":
        return isNominee ? nFIleName2 : gFIleName2;
      case "Nominee 3":
        return isNominee ? nFIleName3 : gFIleName3;
      default:
    }
    notifyListeners();
  }
}
