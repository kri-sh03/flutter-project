// // import 'package:flutter/material.dart';

// // class Dummy extends StatefulWidget {
// //   const Dummy({super.key});

// //   @override
// //   State<Dummy> createState() => _DummyState();
// // }

// // class _DummyState extends State<Dummy> {
// //   bool show = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //           child: ListView.builder(
// //         itemCount: 50,
// //         itemBuilder: (context, index) {
// //           return ListTile(
// //             title: Text("Text ${index + 1}"),
// //           );
// //         },
// //       )),
// //       floatingActionButton: Stack(alignment: Alignment.bottomLeft, children: [
// //         SizedBox(
// //           height: 250.0,
// //           child: ListView(
// //             children: [
// //               FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
// //               FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
// //               FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
// //               FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
// //             ],
// //           ),
// //         ),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.end,
// //           children: [
// //             FloatingActionButton(
// //                 child: Icon(Icons.add),
// //                 onPressed: () {
// //                   show = !show;
// //                   // print("hai");
// //                 }),
// //           ],
// //         ),
// //       ]),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:sms_autofill/sms_autofill.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String _code = "";
//   String signature = "{{ app signature }}";

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               const PhoneFieldHint(),
//               const Spacer(),
//               PinFieldAutoFill(
//                 decoration: UnderlineDecoration(
//                   textStyle: const TextStyle(fontSize: 20, color: Colors.black),
//                   colorBuilder:
//                       FixedColorBuilder(Colors.black.withOpacity(0.3)),
//                 ),
//                 currentCode: _code,
//                 onCodeSubmitted: (code) {},
//                 onCodeChanged: (code) {
//                   if (code!.length == 6) {
//                     FocusScope.of(context).requestFocus(FocusNode());
//                   }
//                 },
//               ),
//               const Spacer(),
//               TextFieldPinAutoFill(
//                 currentCode: _code,
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 child: const Text('Listen for sms code'),
//                 onPressed: () async {
//                   await SmsAutoFill().listenForCode();
//                 },
//               ),
//               ElevatedButton(
//                 child: const Text('Set code to 123456'),
//                 onPressed: () async {
//                   setState(() {
//                     _code = '123456';
//                   });
//                 },
//               ),
//               const SizedBox(height: 8.0),
//               const Divider(height: 1.0),
//               const SizedBox(height: 4.0),
//               Text("App Signature : $signature"),
//               const SizedBox(height: 4.0),
//               ElevatedButton(
//                 child: const Text('Get app signature'),
//                 onPressed: () async {
//                   signature = await SmsAutoFill().getAppSignature;
//                   setState(() {});
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (_) => CodeAutoFillTestPage()));
//                 },
//                 child: const Text("Test CodeAutoFill mixin"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CodeAutoFillTestPage extends StatefulWidget {
//   const CodeAutoFillTestPage({Key? key}) : super(key: key);

//   @override
//   State<CodeAutoFillTestPage> createState() => _CodeAutoFillTestPageState();
// }

// class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage>
//     with CodeAutoFill {
//   String? appSignature;
//   String? otpCode;

//   @override
//   void codeUpdated() {
//     setState(() {
//       otpCode = code!;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     listenForCode();

//     SmsAutoFill().getAppSignature.then((signature) {
//       setState(() {
//         appSignature = signature;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const textStyle = TextStyle(fontSize: 18);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Listening for code"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
//             child: Text(
//               "This is the current app signature: $appSignature",
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Builder(
//               builder: (_) {
//                 if (otpCode == null) {
//                   return const Text("Listening for code...", style: textStyle);
//                 }
//                 return Text("Code Received: $otpCode", style: textStyle);
//               },
//             ),
//           ),
//           const Spacer(),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SliverEx extends StatefulWidget {
  const SliverEx({super.key});

  @override
  State<SliverEx> createState() => _SliverExState();
}

class _SliverExState extends State<SliverEx> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            flexibleSpace: Text(
              "data " * 200,
              style: TextStyle(color: Colors.red),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 100, (context, index) => Text("${index + 1}")))
        ],
      ),
    );
  }
}
