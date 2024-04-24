import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../notification.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



  // void initLocalNotification(BuildContext context, RemoteMessage message) async {
  //   AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/blood_bd');
  //
  //   var initializationSettingsIOS = DarwinInitializationSettings(
  //       requestAlertPermission: true,
  //       requestBadgePermission: true,
  //       requestSoundPermission: true,
  //       onDidReceiveLocalNotification:
  //           (int id, String? title, String? body, String? payload) async {});
  //
  //   var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onDidReceiveNotificationResponse:
  //           (NotificationResponse notificationResponse) async {});
  //
  //   // // var androidInitializationSettings = const AndroidInitializationSettings("@drawable/blood_bd");
  //   // AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@drawable/blood_bd');
  //   // var iosInitializationSettings = DarwinInitializationSettings(
  //   //     requestAlertPermission: true,
  //   //     requestBadgePermission: true,
  //   //     requestSoundPermission: true,
  //   //     onDidReceiveLocalNotification:
  //   //         (int id, String? title, String? body, String? payload) async {});
  //   //
  //   // var initializationSettings = InitializationSettings(
  //   //   android: initializationSettingsAndroid,
  //   //   iOS: iosInitializationSettings,
  //   // );
  //   //
  //   // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //   //     onDidReceiveNotificationResponse: (payload) {});
  // }
  //
  //
  // void showNotification(RemoteMessage message) async {
  //   //
  //   // AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   //   Random.secure().nextInt(10000).toString(),
  //   //   "High importance Notification",
  //   //   importance: Importance.max,
  //   // );
  //   //
  //   //
  //   // AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  //   //   channel.id.toString(),
  //   //   channel.name.toString(),
  //   //   // channelDescription: "Your channel description",
  //   //   importance: Importance.max,
  //   //   // priority: Priority.high,
  //   //   // ticker: "ticker",
  //   // );
  //   //
  //   // DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
  //   //   // presentAlert: true,
  //   //   // presentBadge: true,
  //   //   // presentSound: true,
  //   //   );
  //
  //
  //   // NotificationDetails notificationDetails = NotificationDetails(
  //   //   android: androidNotificationDetails,
  //   //   iOS: darwinNotificationDetails,
  //   // );
  //   NotificationDetails notificationDetails = NotificationDetails(
  //       android: AndroidNotificationDetails('channelId', 'channelName',
  //           importance: Importance.max),
  //       iOS: DarwinNotificationDetails()
  //   );
  //
  //   Future.delayed(Duration.zero, () {
  //    return flutterLocalNotificationsPlugin.show(
  //         0,
  //         message.notification!.title.toString(),
  //         message.notification!.title.toString(),
  //         notificationDetails);
  //   });
  //
  // }






  firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title.toString());
      print(message.notification?.body.toString());

      // showNotification(message);
      LocalNotification()
          .showNotification(title:  message.notification!.title.toString(), body: message.notification!.title.toString());
    });
  }



  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      announcement: true,
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
      criticalAlert: true,
      carPlay: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user provisional permission granted");
    } else {
      print("user permission declined");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }
}
