import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Text ${index + 1}"),
          );
        },
      )),
      floatingActionButton: Stack(alignment: Alignment.bottomLeft, children: [
        SizedBox(
          height: 250.0,
          child: ListView(
            children: [
              FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
              FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
              FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
              FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  show = !show;
                  print("hai");
                }),
          ],
        ),
      ]),
    );
  }
}
