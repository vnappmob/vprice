import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vprice/models/app_model.dart';
import 'package:vprice/views/welcome_screen/local_widgets/welcome_1.dart';
import 'package:provider/provider.dart';
import 'package:vprice/globals.dart' as globals;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController(initialPage: 0);
  final List<Widget> _screens = [
    Welcome1(),
  ];
  bool _lastPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = context.select((AppModel _) => _.appTheme);
    var textColor = globals.appThemeDict[appTheme]['text'] ?? Colors.white;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: _screens,
              onPageChanged: (page) {
                setState(() {
                  _lastPage = page == (_screens.length - 1);
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton(
                    padding: EdgeInsets.all(15),
                    color: globals.appThemeDict[appTheme]['colors'][0],
                    onPressed: () {
                      Provider.of<AppModel>(context, listen: false)
                          .updateAppTutorial(false);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.enter_app,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
