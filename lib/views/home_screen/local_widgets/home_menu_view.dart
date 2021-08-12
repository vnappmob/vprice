import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vprice/models/app_model.dart';
import 'package:vprice/globals.dart' as globals;

class HomeMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    var appHomeScreen = context.select((AppModel _) => _.appHomeScreen);
    final screenList = globals.appHomeScreenDict.keys.toList();
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: List.generate(screenList.length, (index) {
          var screen = globals.appHomeScreenDict[screenList[index]];
          bool lastItem = (index == screenList.length - 1);

          return Column(
            children: [
              ListTile(
                leading: Icon(screen['icon']),
                title: Text(screen['name']),
                trailing: appHomeScreen == screenList[index]
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  Provider.of<AppModel>(context, listen: false)
                      .updateAppHomeScreen(screenList[index])
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                },
              ),
              lastItem
                  ? Container()
                  : Divider(
                      height: 1,
                      color: textColor,
                      indent: 60,
                    ),
            ],
          );
        }),
      ),
    );
  }
}
