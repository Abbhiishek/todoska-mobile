import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const navyColor = Color.fromRGBO(10, 77, 104, 1);
  static const mintColor = Color.fromRGBO(0, 255, 202, 1);
  static const tealColor = Color.fromRGBO(8, 131, 149, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
      shadowColor: tealColor,
      elevation: 0,
      scrimColor: Colors.transparent,
    ),
    iconTheme: const IconThemeData(
      color: mintColor,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      background: drawerColor,
      primary: tealColor,
      secondary: blueColor,
      surface: drawerColor,
      onBackground: whiteColor,
      onPrimary: whiteColor,
      onSecondary: blackColor,
      onSurface: whiteColor,
      error: redColor,
      onError: whiteColor,
    ), // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: const Color.fromARGB(255, 173, 173, 173),
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: navyColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    iconTheme: const IconThemeData(
      color: navyColor,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      background: whiteColor,
      primary: tealColor,
      secondary: blueColor,
      surface: whiteColor,
      onBackground: blackColor,
      onPrimary: drawerColor,
      onSecondary: blackColor,
      onSurface: blackColor,
      error: redColor,
      onError: whiteColor,
    ),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.darkModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
