// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:camera/camera.dart';
import 'package:findcribs/components/constants.dart';
import 'package:findcribs/controller/initialize_controllers.dart';
import 'package:findcribs/models/chat_list_model.dart';
import 'package:findcribs/models/message_model.dart';
import 'package:findcribs/models/user_profile_information_model.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_page.dart';
import 'package:findcribs/screens/authentication_screen/sign_in_verify_email_page.dart';
import 'package:findcribs/screens/onboarding.dart';
import 'package:findcribs/screens/product_details/product_details.dart';
import 'package:findcribs/service/AgentService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nb_utils/nb_utils.dart';

// <<<<<<< gabriel
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'controller/theme_controller.dart';
import 'screens/homepage/home_root.dart';

import 'service/FirebaseMessaging.dart';

ThemeController themeController = Get.put(ThemeController());

// services
AgentService agentService = AgentService();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagings().displayLocalNotification(message);
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialize(aLocaleLanguageList: [
    LanguageDataModel(name: 'English', languageCode: 'en'),
    LanguageDataModel(name: 'Hindi', languageCode: 'hi'),
  ]);
  FirebaseMessagings().handleInit();
  defaultToastBackgroundColor = Colors.black;
  defaultToastTextColor = Colors.white;
  defaultToastGravityGlobal = ToastGravity.CENTER;
  defaultRadius = 16;
  defaultAppButtonRadius = 16;
  // cameras = await availableCameras();
  var prefs = await SharedPreferences.getInstance();
  final appState = prefs.getString('action');
  final email = prefs.getString('email');
  final token = prefs.getString('token');
  print(token);
  runApp(MyApp(appState: appState.toString(), email: email.toString()));
}

class MyApp extends StatefulWidget {
  final String email;
  final String appState;
  const MyApp({super.key, required this.appState, required this.email});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<List<ChatMessageModel>> getChat;

  List<ChatMessageModel> messageList = [];
  List<MessageModel> currentMessageList = [];
  late Future<UserProfile> userProfile;
  Map<String, dynamic> messages = {};
  int? id;
  var messageController = TextEditingController();
  String message = '';
  ScrollController listScrollController = ScrollController();
  bool isTyping = false;
  String isTypingChatId = '';
  String link = 'https://findcribs.page.link/listings';
  String? propertyId;
  String? agentId;

  @override
  void initState() {
    super.initState();
  }


  handleScroll() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent;
      listScrollController.jumpTo(position);
    }
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
    return Obx(
      () => GetMaterialApp(
        builder: scrollBehaviour(),
        navigatorKey: navigatorKey,
        theme: ThemeData.light().copyWith(
          // Customize light theme here

          scaffoldBackgroundColor: mobileBackgroundColor,
          textTheme: ThemeData.dark()
              .textTheme
              .apply(fontFamily: "RedHatDisplay", bodyColor: blackColor),
        ),
        darkTheme: ThemeData.dark().copyWith(
          // Customize dark theme here
          scaffoldBackgroundColor: blackColor,
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: blackColor),
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: blackColor),
          textTheme: ThemeData.dark()
              .textTheme
              .apply(fontFamily: "RedHatDisplay", bodyColor: whiteColor),
        ),
        themeMode: themeController.themeMode.value,
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
        // theme: ThemeData(fontFamily: 'RedHatDisplay'),
        home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: double.maxFinite,
          splash: 'assets/images/splash_screen.gif',
          nextScreen: propertyId.toString() != 'null'
              ? ProductDetails(
                  id: int.parse(
                    propertyId.toString(),
                  ),
                  isDeepLinking: true,
                )
              : widget.appState == 'Verify'
                  ? VerifyEmailScreen(
                      email: widget.email,
                    )
                  : widget.appState == 'LoggedIn'
                      ? const HomePageRoot(
                          navigateIndex: 0,
                        )
                      : widget.appState == 'Login'
                          ? const LoginScreen()
                          : const OnboardingScreen(),
          backgroundColor: const Color(0xFF0070B9),
          centered: true,
        ),
      ),
    );
// >>>>>>> main
  }
}
