import 'package:flutter/material.dart';

import 'package:vprice/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/views/gold_screen/local_widgets/gold_view.dart';

class GoldScreen extends StatelessWidget {
  final Map<String, dynamic> sourceDict = {
    'sjc': {
      'name': 'SJC',
      'code': 'SJC',
    },
    'doji': {
      'name': 'DOJI',
      'code': 'DOJI',
    },
    'pnj': {
      'name': 'PNJ',
      'code': 'PNJ',
    },
  };
  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    var sources = sourceDict.keys.toList();
    return DefaultTabController(
      length: sources.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: globals.appThemeDict[appTheme]['colors'][0],
          iconTheme: IconThemeData(color: textColor),
          title: PreferredSize(
            child: TabBar(
              unselectedLabelColor: textColor,
              labelColor: textColor,
              indicatorColor: textColor,
              tabs: List.generate(sources.length, (index) {
                return Tab(
                  text: sourceDict[sources[index]]['name'],
                );
              }),
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
        ),
        body: TabBarView(
          children: List.generate(sources.length, (index) {
            return GoldView(source: sources[index]);
          }),
        ),
      ),
    );
  }
}
