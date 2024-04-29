import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isdarkTheme = false;
  bool get getIsDarkThmeme => _isdarkTheme;
  ThemeProvider(){
    getTheme();
  }

  setIsDarkTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('theme', value);
    _isdarkTheme = value;
    notifyListeners();
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isdarkTheme = sharedPreferences.getBool('theme') ?? false;

    notifyListeners();
  }
}
