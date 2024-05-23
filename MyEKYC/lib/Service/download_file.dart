import 'dart:io';
import 'dart:typed_data';

import 'package:ekyc/Custom%20Widgets/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

downloadFile(title, Uint8List bytes, fileName, context) async {
  try {
    print(title);
    // print(bytes);
    print(fileName);
    List l = fileName.toString().split(".");
    Directory? dir = await getDownloadsDirectory();
    getApplicationDocumentsDirectory();
    print("dir ${dir!.path}");
    Directory path = Directory("/storage/emulated/0/Download/");

    !path.existsSync() ? await path.create(recursive: true) : null;
    File file = File("${path.path}$title.${l[l.length - 1]}");

    if (file.existsSync()) {
      for (int i = 1; true; i++) {
        File file1 = File("${path.path}$title($i).${l[l.length - 1]}");
        if (!file1.existsSync()) {
          file = file1;
          break;
        }
      }
    }
    file.writeAsBytesSync(bytes);
    // _scheduleNotification();
    ShowPushNotification.showNotification(fileName: file.path);
    // showSnackbar(context, "downloaded sucessfully", Colors.green);
  } catch (e) {
    print(e.toString());
    showSnackbar(context, "some thing went wrong", Colors.red);
  }
}

Future<void> _scheduleNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    channelDescription: 'your channel description',
    icon: '@drawable/ic_lancher',
    importance: Importance.max,
    priority: Priority.high,
  );
  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails();
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await FlutterLocalNotificationsPlugin().show(
    10,
    'New Notification',
    'Hello, World!',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

class ShowPushNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onCLickNotification = BehaviorSubject<String>();
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      BehaviorSubject<String>()
        ..add(details.payload!)
        ..stream.listen((value) async {
          var result = await OpenFile.open(value);
          print(result.type);
        });
    });
  }

  static Future showNotification({required fileName}) async {
    List filedir = fileName.split("/");
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, "downloaded sucessfully",
        filedir[filedir.length - 1], notificationDetails,
        payload: fileName);
  }
}
