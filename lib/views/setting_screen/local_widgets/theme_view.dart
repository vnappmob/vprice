import 'package:flutter/material.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:vprice/models/app_model.dart';
import 'package:provider/provider.dart';

class ThemeView extends StatelessWidget {
  List<Widget> getThemeList(BuildContext context, String? currentTheme) {
    List<Widget> _themes = [];
    globals.appThemeDict.forEach((key, value) {
      _themes.add(
        GestureDetector(
          onTap: () {
            Provider.of<AppModel>(context, listen: false).updateTheme(key);
          },
          child: Container(
            width: 150,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: value['colors'],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: currentTheme == key
                ? Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  )
                : Center(
                    child: Text(
                      value['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ),
      );
    });
    return _themes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: getThemeList(
          context,
          context.select((AppModel _) => _.appTheme),
        ),
      ),
    );
  }
}
