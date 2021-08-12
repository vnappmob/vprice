import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vprice/helper/fetch_data_helper.dart';
import 'package:vprice/views/all_widgets/card_view.dart';
import 'package:vprice/views/all_widgets/price_view.dart';
import 'package:vprice/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:vprice/globals.dart' as globals;

class ExchangeRateView extends StatefulWidget {
  ExchangeRateView({
    required this.source,
  });
  final String source;
  @override
  State<StatefulWidget> createState() {
    return ExchangeRateViewState();
  }
}

class ExchangeRateViewState extends State<ExchangeRateView> {
  final fetchDataHelper = FetchDataHelper.instance;
  late Future<List> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List> fetchData() async {
    final responseBody = await fetchDataHelper.fetchData(
      endpoint: '/api/v2/exchange_rate/${widget.source}',
    );

    return responseBody['results'];
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    var backgroundColor = globals.appThemeDict[appTheme]['colors'][0] ??
        Colors.transparent.withOpacity(0.3);
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: FutureBuilder<List>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return ListView(
                children: List.generate(data!.length, (index) {
                  var item = data[index];
                  return CardView(
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    item['currency'],
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: PriceView(
                                    item['buy_cash'],
                                    textColor: textColor,
                                    backgroundColor: backgroundColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: PriceView(
                                    item['buy_transfer'],
                                    textColor: textColor,
                                    backgroundColor: backgroundColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: PriceView(
                                    item['sell'],
                                    textColor: textColor,
                                    backgroundColor: backgroundColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
