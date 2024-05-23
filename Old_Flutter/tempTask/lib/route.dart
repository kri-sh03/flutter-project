import 'package:temptask/Screen1.dart';
import 'package:temptask/screen2.dart';
import 'package:temptask/screen3.dart';
import 'package:flutter/material.dart';

String screen1 = 'screen1';
String screen2 = 'screen2';
String screen3 = 'screen3';

Route<dynamic> controller(RouteSettings setting) {
  switch (setting.name) {
    case 'screen1':
      return MaterialPageRoute(
        builder: (context) => const Screen1(),
      );
    case 'screen2':
      return MaterialPageRoute(
        builder: (context) => const Screen2(),
      );
    case 'screen3':
      return MaterialPageRoute(
        builder: (context) => const Screen3(),
      );
    default:
      throw "doesn't exist";
  }
}
