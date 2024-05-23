// import 'package:animateproject/shape.dart';
import 'package:flutter/material.dart';

import 'mysnackbar.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Animation Cart',
      debugShowCheckedModeBanner: false,
      home: CustomSnackBar(),
    );
  }
}
