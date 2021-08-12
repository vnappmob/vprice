import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceView extends StatelessWidget {
  PriceView(
    this.price, {
    this.fontSize,
    this.textColor,
    this.backgroundColor,
  });
  final dynamic price;
  final double? fontSize;
  final Color? textColor;
  final Color? backgroundColor;
  final oCcy = new NumberFormat("#,##0", "vi_VN");
  @override
  Widget build(BuildContext context) {
    return price > 0
        ? Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: backgroundColor ?? Colors.white.withOpacity(0.2),
            ),
            child: Text(
              '${oCcy.format(price)}',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container();
  }
}
