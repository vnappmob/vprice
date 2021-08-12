import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/models/app_model.dart';
import 'package:vprice/views/all_widgets/bottom_bar_clipper.dart';
import 'package:vprice/views/setting_screen/setting_screen.dart';

import 'package:provider/provider.dart';

class Welcome1 extends StatefulWidget {
  @override
  _Welcome1State createState() => _Welcome1State();
}

class _Welcome1State extends State<Welcome1> {
  final Color bezelColor = Colors.grey;
  final double bezelSize = 15;
  final double bezelRadius = 40;
  final double bottomSize = 60;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffe0e8ef),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListView(
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.getting_started,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  padding: EdgeInsets.all(15),
                  color: globals.appThemeDict[appTheme]['colors'][0],
                  child: Text(
                    'System settings',
                    style: TextStyle(color: textColor),
                  ),
                  onPressed: () {
                    AppSettings.openNotificationSettings();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(bezelRadius),
                ),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(width: bezelSize, color: bezelColor),
                      right: BorderSide(width: bezelSize, color: bezelColor),
                      bottom: BorderSide(width: bezelSize, color: bezelColor),
                    ),
                    color: bezelColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(bezelRadius - bezelSize),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: globals.appThemeDict[appTheme]['colors'],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: bottomSize * 0.53,
                            right: 0,
                            left: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {},
                                onLongPress: () {},
                                child: FloatingActionButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.watch_later,
                                    color: textColor,
                                  ),
                                  backgroundColor: globals
                                      .appThemeDict[appTheme]['colors'][0],
                                ),
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
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomLeft,
                                    colors: globals.appThemeDict[appTheme]
                                        ['colors'],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: CupertinoButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SettingScreen(),
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
