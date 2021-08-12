import 'package:flutter/material.dart';
import 'package:vprice/views/gold_screen/local_widgets/gold_doji_view.dart';
import 'package:vprice/views/gold_screen/local_widgets/gold_pnj_view.dart';
import 'package:vprice/views/gold_screen/local_widgets/gold_sjc_view.dart';
import 'package:vprice/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:vprice/globals.dart' as globals;

class GoldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: globals.appThemeDict[appTheme]['colors'][0],
          iconTheme: IconThemeData(color: textColor),
          title: TabBar(
            tabs: [
              Tab(text: 'SJC'),
              Tab(text: 'DOJI'),
              Tab(text: 'PNJ'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GoldSJCView(),
            GoldDojiView(),
            GoldPNJView(),
          ],
        ),
      ),
    );
  }
}
