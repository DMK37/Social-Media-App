import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/theme/dark_theme.dart';
import 'package:social_media/theme/light_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme) {
    loadTheme();
  }

  void changeTheme() {
    if (state == lightTheme) {
      saveTheme(false);
      emit(darkTheme);
    } else {
      saveTheme(true);
      emit(lightTheme);
    }
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("isLightTheme")) {
      await prefs.setBool(
          'isLightTheme',
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.light);
    }
    bool isLightTheme = prefs.getBool('isLightTheme') ?? true;
    emit(isLightTheme ? lightTheme : darkTheme);
  }

  void saveTheme(bool isLightTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLightTheme', isLightTheme);
  }
}
