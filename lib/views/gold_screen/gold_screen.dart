import 'package:flutter/material.dart';
import 'package:vprice/views/gold_screen/local_widgets/gold_doji_view.dart';
import 'package:vprice/views/gold_screen/local_widgets/gold_pnj_view.dart';
import 'package:vprice/views/gold_screen/local_widgets/gold_sjc_view.dart';

class GoldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
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
