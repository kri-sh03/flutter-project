import 'dart:io';

import 'package:ekyc/Cookies/HttpClient.dart';
import 'package:ekyc/Cookies/cookies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Custom Widgets/custom_button.dart';
import '../Route/route.dart' as route;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int pageIndex = 0;
  static List images = [
    'assets/images/facelock.png',
    'assets/images/security.png',
    'assets/images/fingerprint.png',
    'assets/images/sebi.png',
  ];
  static List subTitiles = [
    'PAN number, Aadhar number, Aadhar registered mobile number',
    'Driving License/ Voter ID/ Passport/ Ration Card',
    'Six month bank statement/ Cancelled cheque/ Passbook front page',
    'Ensure your Pan is linked with Aadhar to open your account as mandated by SEBI',
  ];

  List pages = List.generate(
    images.length,
    (index) => Pages(
      img: images[index],
      txt: subTitiles[index],
    ),
  );

  @override
  void initState() {
    CustomHttpClient.addTrustedCertificate();
    super.initState();
    String platform = Platform.isAndroid
        ? 'Android'
        : Platform.isIOS
            ? 'iOS'
            : 'Unknown';
    CustomHttpClient.headers["User-Agent"] = 'YourApp/1.0 ($platform)';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("assets/images/background_image.png"))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                Transform.scale(
                    scale: 1.5,
                    child: Image.asset("assets/images/flattrade.png")),
                const SizedBox(
                  height: 3.0,
                ),
                const Text(
                  "Absolute Zero Brokerage",
                  style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(171, 171, 171, 1)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Open Online',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Demat & Trading Account',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 22,
                      color: const Color.fromRGBO(9, 101, 218, 1)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'In Just 5 Minutes',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: const Color.fromRGBO(60, 95, 140, 1)),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: pages.length,
                    onPageChanged: (value) {
                      pageIndex = value;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return pages[index];
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.circle,
                        color: pageIndex == index
                            ? const Color.fromRGBO(9, 101, 218, 1)
                            : Colors.transparent,
                      ),
                      child: const Text(''),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  childText: 'Lets Start!',
                  onPressed: pageIndex == pages.length - 1
                      ? () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            route.signup,
                            (route) => false,
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Pages extends StatelessWidget {
  final String img;
  final String txt;
  const Pages({
    super.key,
    required this.img,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // border: Border.all(),
          borderRadius: BorderRadius.circular(17),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              color: Color.fromRGBO(9, 101, 218, 0.25),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Keep the following Documents handy for seamless Account opening',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(60, 95, 140, 1),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Image.asset(img),
                  const SizedBox(height: 10.0),
                  Text(
                    txt,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(69, 90, 100, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
