import 'package:flutter/material.dart';
import 'package:vprice/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/views/exchange_rate_screen/local_widgets/exchange_rate_view.dart';

class ExchangeRateScreen extends StatelessWidget {
  final Map<String, dynamic> sourceDict = {
    'vcb': {
      'name': 'Vietcombank',
      'code': 'VCB',
    },
    'ctg': {
      'name': 'Vietinbank',
      'code': 'CTG',
    },
    'bid': {
      'name': 'BIDV',
      'code': 'BID',
    },
    'tcb': {
      'name': 'Techcombank',
      'code': 'TCB',
    },
    'stb': {
      'name': 'Sacombank',
      'code': 'STB',
    },
  };
  final List methods = ['Buy cash', 'Buy transfer', 'Sell'];
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
              isScrollable: true,
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: Row(
              children: List.generate(methods.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        methods[index],
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(sources.length, (index) {
            return ExchangeRateView(source: sources[index]);
          }),
        ),
      ),
    );
  }
}
