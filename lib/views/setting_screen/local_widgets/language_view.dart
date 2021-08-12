import 'package:flutter/material.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/models/app_model.dart';
import 'package:vprice/models/language_model.dart';
import 'package:vprice/views/setting_screen/local_widgets/language_screen.dart';
import 'package:provider/provider.dart';

class LanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    var appLangCode = context.select((LanguageModel _) => _.appLangCode);
    String languageName = globals.appLanguageDict[appLangCode] ?? '';
    return ListTile(
      leading: Icon(
        Icons.translate,
        color: textColor,
      ),
      title: Text(
        languageName,
        style: TextStyle(color: textColor),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: textColor,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LanguageScreen(),
          ),
        );
      },
    );
  }
}
