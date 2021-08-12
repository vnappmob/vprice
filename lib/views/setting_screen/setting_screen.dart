import 'package:flutter/material.dart';
import 'package:vprice/models/app_model.dart';
import 'package:vprice/views/all_widgets/card_view.dart';
import 'package:vprice/views/setting_screen/local_widgets/about_view.dart';
import 'package:vprice/views/setting_screen/local_widgets/theme_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vprice/globals.dart' as globals;

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.setting,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: globals.appThemeDict[appTheme]['colors'][0],
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: globals.appThemeDict[appTheme]['colors'],
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: ListView(
          children: [
            CardView(
              headTitle: Text(
                AppLocalizations.of(context)!.theme,
                style: TextStyle(color: textColor),
              ),
              child: ThemeView(),
            ),
            CardView(
              headTitle: Text(
                AppLocalizations.of(context)!.credit,
                style: TextStyle(color: textColor),
              ),
              child: AboutView(),
            ),
          ],
        ),
      ),
    );
  }
}
