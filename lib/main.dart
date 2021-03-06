import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:vprice/models/app_model.dart';
import 'package:vprice/models/language_model.dart';
import 'package:vprice/views/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:vprice/globals.dart' as globals;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootApp();
}

Future<void> bootApp() async {
  print('---fetchAppModel---');
  AppModel appModel = AppModel();
  await appModel.fetchSaved();

  print('---fetchLanguageModel---');
  LanguageModel languageModel = LanguageModel();
  await languageModel.fetchLocale();

  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(create: (_) => appModel),
        ChangeNotifierProvider<LanguageModel>(create: (_) => languageModel),
      ],
      child: InitApp(),
    ),
  );
}

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageModel>(
      builder: (_, data, child) {
        return MaterialApp(
          locale: data.appLocale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'vPrice',
          theme: ThemeData(
            platform: TargetPlatform.iOS,
            primarySwatch: Colors.blueGrey,
          ),
          home: RateMyAppBuilder(
            builder: (context) {
              return HomeScreen();
            },
            rateMyApp: RateMyApp(
              preferencesPrefix: 'rateMyApp_',
              minDays: 1,
              minLaunches: 2,
              remindDays: 7,
              remindLaunches: 10,
              googlePlayIdentifier: globals.googlePlayIdentifier,
              appStoreIdentifier: globals.appStoreIdentifier,
            ),
            onInitialized: (context, rateMyApp) {
              if (rateMyApp.shouldOpenDialog) {
                rateMyApp.showRateDialog(context);
              }
            },
          ),
        );
      },
    );
  }
}
