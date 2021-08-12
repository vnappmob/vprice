// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:vprice/main.dart';
import 'package:vprice/models/app_model.dart';
import 'package:vprice/models/language_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test Home Screen', (WidgetTester tester) async {
    AppModel appModel = AppModel();
    LanguageModel languageModel = LanguageModel();

    appModel.updateAppTutorial(false);

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(create: (_) => appModel),
        ChangeNotifierProvider<LanguageModel>(create: (_) => languageModel),
      ],
      child: InitApp(),
    ));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
