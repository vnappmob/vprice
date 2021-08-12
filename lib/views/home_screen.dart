import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/models/app_model.dart';
import 'package:vprice/views/all_widgets/bottom_bar_clipper.dart';
import 'package:vprice/views/iap_screen/iap_screen.dart';
import 'package:vprice/views/setting_screen/setting_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vprice/views/welcome_screen/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

final platformChannel =
    const MethodChannel('com.vnappmob.vprice/platformChannel');

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final double bottomSize = 60;
  int batteryLevel = 0;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  Future<void> getBatteryInfo() async {
    if (Platform.isIOS) {
      try {
        final int result = await platformChannel.invokeMethod('batteryLevel');
        setState(() {
          batteryLevel = result;
        });
        print('Battery level at $result % .');
      } on PlatformException catch (e) {
        print("Failed to get battery level: '${e.message}'.");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    var appTutorial = context.select((AppModel _) => _.appTutorial);
    return Scaffold(
      body: IndexedStack(
        index: appTutorial ? 0 : 1,
        children: [
          appTutorial ? WelcomeScreen() : Container(),
          appTutorial
              ? Container()
              : Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 100),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: globals.appThemeDict[appTheme]['colors'],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: bottomSize * 0.53,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.watch_later,
                            color: textColor,
                          ),
                          backgroundColor: globals.appThemeDict[appTheme]
                              ['colors'][0],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                        clipper: BottomBarClipper(centerSize: bottomSize),
                        child: Container(
                          height: bottomSize,
                          decoration: BoxDecoration(
                            color: globals.appThemeDict[appTheme]['colors'][0],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CupertinoButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => IAPScreen(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: CupertinoButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.setting,
                                    style: TextStyle(color: textColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            '$batteryLevel%',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
