import 'package:flutter/material.dart';
import 'package:vprice/helper/fetch_data_helper.dart';
import 'package:vprice/views/all_widgets/card_view.dart';
import 'package:vprice/views/all_widgets/price_view.dart';

class GoldPNJView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoldPNJViewState();
  }
}

class GoldPNJViewState extends State<GoldPNJView> {
  final fetchDataHelper = FetchDataHelper.instance;
  late Future<List> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List> fetchData() async {
    final responseBody =
        await fetchDataHelper.fetchData(endpoint: '/api/v2/gold/pnj');
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
