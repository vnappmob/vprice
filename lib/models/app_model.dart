import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModel extends ChangeNotifier {
  bool _appTutorial = true;
  bool get appTutorial => _appTutorial;
  Future<void> updateAppTutorial(bool value) async {
    _appTutorial = value;
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('appTutorial', value);

    notifyListeners();
  }

  String _appTheme = 'light';
  String get appTheme => _appTheme;
  Future<void> updateTheme(String value) async {
    _appTheme = value;

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('appTheme', _appTheme);

    notifyListeners();
  }

  String _appHomeScreen = 'gold';
  String get appHomeScreen => _appHomeScreen;
  Future<void> updateAppHomeScreen(String value) async {
    _appHomeScreen = value;

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('appHomeScreen', _appHomeScreen);

    notifyListeners();
  }

  Future<void> fetchSaved() async {
    var prefs = await SharedPreferences.getInstance();

    _appTutorial = prefs.getBool('appTutorial') ?? _appTutorial;
    print('---appTutorial: $_appTutorial');
    _appTheme = prefs.getString('appTheme') ?? _appTheme;
    print('---appTheme: $_appTheme');
    _appHomeScreen = prefs.getString('appHomeScreen') ?? _appHomeScreen;
    print('---appHomeScreen: _appHomeScreen');
  }
}
