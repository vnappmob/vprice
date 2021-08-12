import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/helper/fetch_data_helper.dart';
import 'package:vprice/views/all_widgets/card_view.dart';
import 'package:vprice/views/all_widgets/price_view.dart';

class GoldSJCView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoldSJCViewState();
  }
}

class GoldSJCViewState extends State<GoldSJCView> {
  final fetchDataHelper = FetchDataHelper.instance;
  late Future<List> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List> fetchData() async {
    final responseBody =
        await fetchDataHelper.fetchData(endpoint: '/api/v2/gold/sjc');
    Map<String, dynamic> resultDict = responseBody['results'][0];

    List data = [[], []];
    resultDict.forEach((key, value) {
      var item = {
        'id': key,
        'name': mapName[key],
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

  Map<String, dynamic> mapName = {
    'buy_1l': 'SJC 1L, 10L',
    'buy_1c': 'SJC 1c',
    'buy_nhan1c': 'Nhẫn 1c',
    'buy_trangsuc49': 'Trang sức 9999',
    'sell_1l': 'SJC 1L, 10L',
    'sell_1c': 'SJC 1c',
    'sell_nhan1c': 'Nhẫn 1c',
    'sell_trangsuc49': 'Trang sức 9999',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    headTitle: Text('test'),
                    child: Column(
                      children: List.generate(group.length, (index) {
                        var item = group[index];
                        return Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(child: Text('${item['name']}')),
                              Expanded(
                                child: PriceView(item['value']),
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

// class GoldPriceView extends StatelessWidget {
//   GoldPriceView(this.price);
//   final dynamic price;
//   final oCcy = new NumberFormat("#,##0", "vi_VN");
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white54,
//       ),
//       child: Text(
//         '${oCcy.format(price)}',
//         textAlign: TextAlign.end,
//         style: TextStyle(
//           // color: Colors.white,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
