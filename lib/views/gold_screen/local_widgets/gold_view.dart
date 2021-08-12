import 'package:flutter/material.dart';
import 'package:vprice/helper/fetch_data_helper.dart';
import 'package:vprice/views/all_widgets/card_view.dart';
import 'package:vprice/views/all_widgets/price_view.dart';
import 'package:vprice/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:vprice/globals.dart' as globals;

class GoldView extends StatefulWidget {
  GoldView({
    required this.source,
  });
  final String source;
  @override
  State<StatefulWidget> createState() {
    return GoldViewState();
  }
}

class GoldViewState extends State<GoldView> {
  final fetchDataHelper = FetchDataHelper.instance;
  late Future<List> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List> fetchData() async {
    final responseBody = await fetchDataHelper.fetchData(
      endpoint: '/api/v2/gold/${widget.source}',
    );
    Map<String, dynamic> resultDict = responseBody['results'][0];

    List data = [[], []];
    resultDict.forEach((key, value) {
      var item = {
        'id': key,
        'name': mapNames[widget.source][key],
        'value': value,
      };
      if (key.contains('buy')) {
        data[0].add(item);
      } else if (key.contains('sell')) {
        data[1].add(item);
      }
    });

    return data;
  }

  Map<String, dynamic> mapNames = {
    'doji': {
      'buy_ct': 'Cần Thơ',
      'buy_dn': 'Đà Nẵng',
      'buy_hcm': 'HCM',
      'buy_hn': 'Hà Nội',
      'sell_ct': 'Cần Thơ',
      'sell_dn': 'Đà Nẵng',
      'sell_hcm': 'HCM',
      'sell_hn': 'Hà Nội',
    },
    'pnj': {
      'buy_nhan_24k': 'Nhẫn 24k',
      'buy_nt_10k': 'Nữ trang 10k',
      'buy_nt_14k': 'Nữ trang 14k',
      'buy_nt_18k': 'Nữ trang 18k',
      'buy_nt_24k': 'Nữ trang 24k',
      'sell_nhan_24k': 'Nhẫn 24k',
      'sell_nt_10k': 'Nữ trang 10k',
      'sell_nt_14k': 'Nữ trang 14k',
      'sell_nt_18k': 'Nữ trang 18k',
      'sell_nt_24k': 'Nữ trang 24k',
    },
    'sjc': {
      'buy_1l': 'SJC 1L, 10L',
      'buy_1c': 'SJC 1c',
      'buy_nhan1c': 'Nhẫn 1c',
      'buy_trangsuc49': 'Trang sức 9999',
      'sell_1l': 'SJC 1L, 10L',
      'sell_1c': 'SJC 1c',
      'sell_nhan1c': 'Nhẫn 1c',
      'sell_trangsuc49': 'Trang sức 9999',
    }
  };

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
                  List group = data[index];
                  return CardView(
                    headTitle: Text(
                      index == 0 ? 'Buy' : 'Sell',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Column(
                      children: List.generate(group.length, (index) {
                        var item = group[index];
                        return Container(
                          padding: EdgeInsets.all(3),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${item['name']}',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: PriceView(
                                  item['value'],
                                  textColor: textColor,
                                  backgroundColor: backgroundColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
