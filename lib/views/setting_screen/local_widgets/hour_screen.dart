import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/models/app_model.dart';
import 'package:vprice/views/all_widgets/card_view.dart';
import 'package:provider/provider.dart';

class HourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.active_hour,
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
              child: Consumer<AppModel>(
                builder: (_, data, child) {
                  return Column(
                    children: List.generate(24, (i) {
                      bool lastItem = (i == 23);
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              '${i}:00',
                              style: TextStyle(color: textColor),
                            ),
                            trailing: data.activeHours[i.toString()]
                                ? Icon(
                                    Icons.check,
                                    color: textColor,
                                  )
                                : null,
                            onTap: () {
                              Provider.of<AppModel>(context, listen: false)
                                  .updateActiveHours(i.toString());
                            },
                          ),
                          lastItem
                              ? Container()
                              : Divider(
                                  height: 1,
                                  color: textColor,
                                  indent: 0,
                                ),
                        ],
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
