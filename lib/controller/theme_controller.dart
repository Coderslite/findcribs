import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  void toggleThemeMode(ThemeMode mode) async {
    var prefs = await SharedPreferences.getInstance();

    themeMode.value = mode;
    prefs.setString('theme', "$mode");

    update();
  }

  // ThemeData getThemeData() {
  //   if (themeMode.value == ThemeMode.light) {
  //     return ThemeData.light();
  //   } else {
  //     return ThemeData.dark();
  //   }
  // }

  @override
  onInit() {
    super.onInit();
    handleGetTheme();
  }

  handleGetTheme() async {
    var prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString('theme').toString();
    print("theme $theme");
    if (theme == "ThemeMode.dark") {
      themeMode.value = ThemeMode.dark;
      print("darkmode");
    } else if (theme == "ThemeMode.light") {
      themeMode.value = ThemeMode.light;
      print("lightmode");
    } else {
      themeMode.value = ThemeMode.system;
      print("systemmode");
    }
    update();
  }
}
