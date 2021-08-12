import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceView extends StatelessWidget {
  PriceView(this.price);
  final dynamic price;
  final oCcy = new NumberFormat("#,##0", "vi_VN");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Text(
        price > 0 ? '${oCcy.format(price)}' : '-',
        textAlign: TextAlign.end,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
