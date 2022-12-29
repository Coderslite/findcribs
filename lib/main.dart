// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:findcribs/controller/initialize_controllers.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:findcribs/models/message_model.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_page.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_verify_email_page.dart';
import 'package:findcribs/screens/onboarding.dart';
import 'package:findcribs/service/get_chat_service.dart';
import 'package:findcribs/service/user_profile_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// <<<<<<< gabriel

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:system_settings/system_settings.dart';

import 'screens/homepage/home_root.dart';
import 'screens/story/story_camera.dart';
import 'package:permission_handler/permission_handler.dart';


// import 'authentication_screen/sign_up_page.dart';
// =======
// import 'package:flutter/services.dart';
// import 'screens/onboarding.dart';
// >>>>>>> main
@pragma('vm:entry-point')

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {}
  channel = const AndroidNotificationChannel(
    'com.findcribs', // id
    'FindCribs Notification Permission', // title
    description: 'Please turn on notification on the app', // description
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  // print('Handling a background message ${message.messageId}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android.smallIcon,
          colorized: true,
        ),
      ),
    );
  }
}

void showFlutterNotification(RemoteMessage message) {

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    print(message);
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android.smallIcon,
          colorized: true,
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, macOS: null, iOS: null);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp();

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  var notificationPermission = await Permission.notification.isGranted;
  if (notificationPermission == false) {
    Fluttertoast.showToast(msg: "Notification Permission Required")
        .then((value) => SystemSettings.appNotifications());
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.requestPermission().then((value) async {
    messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    var prefs = await SharedPreferences.getInstance();

    messaging.getToken().then((token) {
      prefs.setString('fcmToken', token.toString());
      print(
        "token$token",
      );
    });

    cameras = await availableCameras();
    final appState = prefs.getString('action');
    final email = prefs.getString('email');
    final token = prefs.getString('token');
    print(token);
    print(email);
    runApp(MyApp(
      appState: appState.toString(),
      email: email.toString(),
    ));
  }).onError((error, stackTrace) {
    Fluttertoast.showToast(msg: "Notification Permission Required")
        .then((value) => SystemSettings.appNotifications());
  });
}

class MyApp extends StatefulWidget {
  final String email;
  final String appState;
  const MyApp({Key? key, required this.appState, required this.email})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<ChatMessageModel>> getChat;

  List<ChatMessageModel> messageList = [];
  List<MessageModel> currentMessageList = [];
  late Future<UserProfile> userProfile;
  List myMessage = [];
  Map<String, dynamic> messages = {};
  int? id;
  late Socket socket;
  late List online;
  var messageController = TextEditingController();
  String message = '';
  ScrollController listScrollController = ScrollController();
  bool isTyping = false;
  String isTypingChatId = '';

  @override
  void initState() {
    online = [];
    handleGetMessages();
    // handleConnect();
    handleGetUserProfile();
    super.initState();
  }

  handleScroll() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent;
      listScrollController.jumpTo(position);
    }
  }

  handleGetMessages() async {
    getChat = getMessageList();
    getChat.then((value) {
      setState(() {
        handleScroll();
        messageList = value;
        // myMessage.add(messages);
      });
    });
  }

  handleGetUserProfile() async {
    userProfile = getUserProfile();
    userProfile.then((value) {
      setState(() {
        id = value.id!;
      });
    });
  }

  handleOnline(data) {
    var userOnline = jsonDecode(data);
    bool check = online.contains(userOnline['id']);
    if (check == false) {
      if (mounted) {
        setState(() {
          online.add(userOnline['id']);
          print(online);
        });
      }
    }
  }

  handleOffline(data) {
    var userOnline = jsonDecode(data);
    setState(() {
      online.remove(userOnline['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
// <<<<<<< gabriel
//     return const GetMaterialApp(
//         debugShowCheckedModeBanner: false, home: EmailScreen());
// =======
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        //color set to transperent
      ),
    );
    return GetMaterialApp(
      initialBinding: HomeBindings(),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
        Locale('fa', ''),
        Locale('fr', ''),
        Locale('ja', ''),
        Locale('pt', ''),
        Locale('sk', ''),
        Locale('pl', ''),
      ],
      debugShowCheckedModeBanner: false,
      title: 'FindCribs',
      theme: ThemeData(fontFamily: 'RedHatDisplay'),
      home: AnimatedSplashScreen(
        duration: 3000,
        splashIconSize: double.maxFinite,
        splash: 'assets/images/splash_screen.gif',
        nextScreen: widget.appState == 'Verify'
            ? VerifyEmailScreen(
                email: widget.email,
              )
            : widget.appState == 'LoggedIn'
                ? HomePageRoot(
                    navigateIndex: 0,
                  )
                : widget.appState == 'Login'
                    ? const LoginScreen()
                    : const OnboardingScreen(),
        backgroundColor: const Color(0xFF0070B9),
        centered: true,
      ),
    );
// >>>>>>> main
  }
}
