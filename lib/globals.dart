library vprice.globals;

import 'package:flutter/material.dart';

const bool PRODUCTION = bool.fromEnvironment('dart.vm.product');

const String googlePlayIdentifier = 'com.vnappmob.vprice';
const String appStoreIdentifier = 'id1579234302';
const String googlePlayUrl =
    'https://play.google.com/store/apps/details?id=com.vnappmob.vprice';
const String appStoreUrl = 'https://apps.apple.com/app/id1579234302';
const String appShareSubject = 'Please check out this cool app! ';
const String appSupportUrl = 'https://app.vnappmob.com';

const Map<String, String> appLanguageDict = const <String, String>{
  'en': 'English',
  'vi': 'Tiếng Việt'
};

final Map<String, dynamic> appThemeDict = const <String, dynamic>{
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
