library vprice.globals;

import 'package:flutter/material.dart';
import 'package:vprice/views/exchange_rate_screen/exchange_rate_screen.dart';
import 'package:vprice/views/gold_screen/gold_screen.dart';

const bool PRODUCTION = bool.fromEnvironment('dart.vm.product');

const String googlePlayIdentifier = 'com.vnappmob.vprice';
const String appStoreIdentifier = 'id1477505685';
const String googlePlayUrl =
    'https://play.google.com/store/apps/details?id=com.vnappmob.vprice';
const String appStoreUrl = 'https://apps.apple.com/app/id1477505685';
const String appShareSubject = 'Please check out this cool app! ';
const String appSupportUrl = 'https://app.vnappmob.com';

const String apiHost = 'https://vapi.vnappmob.com';
const String apiKey =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjI0OTI2NjE4MTQsImlhdCI6MTYyODc0ODIxNCwic2NvcGUiOiIqIiwicGVybWlzc2lvbiI6MH0.3h6hiLx36f0jCWAYn5Wu1HERhvTwrHkNUncJa-QQmHo';

const Map<String, String> appLanguageDict = const <String, String>{
  'en': 'English',
  'vi': 'Tiếng Việt'
};

final Map<String, dynamic> appHomeScreenDict = {
  'gold': {
    'name': 'Gold',
    'icon': Icons.bar_chart,
    'widget': GoldScreen(),
  },
  'exchange_rate': {
    'name': 'Exchange rate',
    'icon': Icons.money,
    'widget': ExchangeRateScreen(),
  },
};

final Map<String, dynamic> appThemeDict = const <String, dynamic>{
  'basic': {
    'name': 'Basic',
    'colors': [
      Colors.blue,
      Colors.indigo,
    ],
    'sub_colors': [
      Colors.blue,
      Colors.greenAccent,
    ],
  },
  'light': {
    'name': 'Light',
    'colors': [
      Color(0xFFFAFAFA),
      Color(0xFFA9AFC0),
    ],
    'text': Color(0xFF6A6163),
  },
  'plum_plate': {
    'name': 'Plum Plate',
    'colors': [
      Color(0xFF667EEA),
      Color(0xFF764BA2),
    ]
  },
  'influenza': {
    'name': 'Influenza',
    'colors': [
      Color(0xFFC04848),
      Color(0xFF480048),
    ]
  },
  'royal_blue': {
    'name': 'Royal Blue',
    'colors': [
      Color(0xFF536976),
      Color(0xFF292E49),
    ]
  },
};
