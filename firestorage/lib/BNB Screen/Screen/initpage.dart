import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firestorage/BNB%20Screen/businesspage.dart';
import 'package:firestorage/BNB%20Screen/homepage.dart';
import 'package:firestorage/BNB%20Screen/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);
    analytics.logViewCart(items: [AnalyticsEventItem()]);
    analytics.setSessionTimeoutDuration(
        const Duration(minutes: 5)); // Set session timeout duration

    super.initState();
  }

  int selectedIndex = 0;
  List pageNames = ['Home_Page', 'Business_Page', 'Profile_Page'];
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  List widgetOptions = [
    HomePage(),
    BusinessPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireBase Analytics'),
      ),
      body: Center(
        child: /* widgetOptions.elementAt(selectedIndex) */
            ElevatedButton(
                onPressed: () {
                  launchUrlString(
                      'https://flattrade.s3.ap-south-1.amazonaws.com/instakyc/DP_Tariff_and_Other_Charges.pdf');
                },
                child: Text('Click to launch')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: (index) async {
          await analytics.logEvent(
              name: '${pageNames[index]}',
              parameters: {
                'page_name': pageNames[index],
                'User': index,
              },
              callOptions: AnalyticsCallOptions(global: true));
          setState(() {
            // FirebaseAnalytics.instance.logScreenView(
            //   screenName: pageNames[index],
            //   screenClass: pageNames[index],
            // );
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
