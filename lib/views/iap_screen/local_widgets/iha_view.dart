import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/models/app_model.dart';
import 'package:vprice/views/all_widgets/card_view.dart';

class InHouseApp extends StatelessWidget {
  final _userDefaultsChannel =
      const MethodChannel('vprice.vnappmob.com/UserDefaultsChannel');
  final List<Map<String, dynamic>> apps = [
    {
      'title': 'vLunar',
      'description': 'Vietnamese lunar calendar',
      'icon': 'assets/iha/vlunar.png',
      'icon_png': true,
      'ios_link': '1531851878',
      'android_link': 'http://onelink.to/xmwnpy',
    },
    {
      'title': 'PipPip',
      'description': 'Get notify on every new hour',
      'icon': 'assets/iha/pippip.svg',
      'ios_link': '1579234302',
      'android_link': 'http://onelink.to/undta5',
    },
    {
      'title': 'MoPip',
      'description': 'Diary book with privacy first',
      'icon': 'assets/iha/mopip.svg',
      'ios_link': '1577123436',
      'android_link': 'http://onelink.to/22yxb5',
    }
  ];
  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    return CardView(
      headTitle: Text(
        'Apps',
        style: TextStyle(
          color: textColor,
        ),
      ),
      child: Column(
        children: List.generate(apps.length, (index) {
          Map<String, dynamic> app = apps[index];
          return Card(
            elevation: 4,
            color: globals.appThemeDict[appTheme]['colors'][0],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 50,
                  width: 50,
                  child: app['icon_png'] ?? false
                      ? Image.asset(app['icon'])
                      : SvgPicture.asset(
                          app['icon'] ?? '',
                          semanticsLabel: app['title'],
                        ),
                ),
              ),
              title: Text(
                app['title'] ?? '',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              subtitle: Text(
                app['description'] ?? '',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              onTap: () async {
                if (Platform.isIOS) {
                  _userDefaultsChannel
                      .invokeMethod('openProduct', {'appId': app['ios_link']});
                } else if (Platform.isAndroid) {
                  if (await canLaunch(app['android_link'] ?? '')) {
                    await launch(app['android_link'] ?? '');
                  }
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
