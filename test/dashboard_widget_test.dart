import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {
  testWidgets('Should display the main image when the dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Dashboard(
      contatoDAO: ContatoDAO(),
    )));

    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets(
      'Should display the transfer feature when the dashboard is opened',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Dashboard(contatoDAO: ContatoDAO())));

    final transferFeature = find.byWidgetPredicate((widget) {
      return featureItemMatcher(widget, 'Transfer', Icons.monetization_on);
    });

    expect(transferFeature, findsOneWidget);
  });

  testWidgets(
      'Should display the transaction feed feature when the dashboard is opened',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Dashboard(contatoDAO: ContatoDAO())));

    final transactionFeedFeature = find.byWidgetPredicate((widget) {
      return featureItemMatcher(widget, 'Transaction Feed', Icons.description);
    });

    expect(transactionFeedFeature, findsOneWidget);
  });
}
