import 'package:first_project/main.dart';
import 'package:first_project/models/contact.dart';
import 'package:first_project/screens/contatos/formulario.dart';
import 'package:first_project/screens/contatos/lista.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {

  const String FULLNAME = 'Gnome';
  const int ACCOUNT_NUMBER = 123456;

  testWidgets('Should save a contact', (tester) async {
    final mockContatoDao = MockContatoDao();
    await tester.pumpWidget(Bytebank(
      contatoDAO: mockContatoDao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);

    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactList);
    expect(contactsList, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);

    final floatingActionButtonNewContact =
        find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(floatingActionButtonNewContact, findsOneWidget);
    await tester.tap(floatingActionButtonNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContatosFormulario);
    expect(contactForm, findsOneWidget);

    final nameTextField =
        find.byWidgetPredicate((widget) => textFieldMatcher(widget,'Nome completo'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, FULLNAME);

    final accountNumberTextField = find.byWidgetPredicate(
        (widget) => textFieldMatcher(widget, 'Numero da conta'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, ACCOUNT_NUMBER.toString());

    final createButton = find.widgetWithText(RaisedButton, 'Salvar');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();
    verify(mockContatoDao.save(Contact(0, FULLNAME, ACCOUNT_NUMBER)));

    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContatoDao.findAll());
  });
}


