// ignore_for_file: deprecated_member_use

import 'package:findcribs/firebase_options.dart';
import 'package:findcribs/util/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

class FirebaseMessagings {
  void displayLocalNotification(RemoteMessage message) async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'com.findcribs',
      'FindCribs Notification Permission',
      channelDescription: 'Please turn on notification on the app',
      channelShowBadge: true,
      importance: Importance.max,
      priority: Priority.high,
      colorized: true,
      color: blue,
      enableLights: true,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  handleInit() async {
    if (isMobile && !kIsWeb) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings darwinInitializationSettings =
          DarwinInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: darwinInitializationSettings);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        // onDidReceiveNotificationResponse: notificationTapBackground,
        // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
      // Request notification permissions

      var result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();

      if (result == true) {
      } else {}
      var prefs = await SharedPreferences.getInstance();
      var token = await firebaseMessaging.getToken();
      print("fcmToken, $token");
      prefs.setString('fcmToken', token.toString());

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

      // Handle incoming messages and display notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("received notification");
        displayLocalNotification(message);
      });
    }
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin
        .cancelAll(); // or specify specific notification ID to cancel
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('AppointmentId');
  }
}
