import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/http/webclients/transaction_webclient.dart';
import 'package:first_project/main.dart';
import 'package:first_project/models/contact.dart';
import 'package:first_project/screens/contatos/formulario.dart';
import 'package:first_project/screens/contatos/lista.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  const String FULLNAME = 'Gnome';
  const int ACCOUNT_NUMBER = 99;

  testWidgets('Should save a contact', (tester) async {
    final mockContatoDao = MockContatoDao();
    await tester.pumpWidget(Bytebank(
      transactionWebClient: TransactionWebClient(),
      contatoDAO: ContatoDAO(),
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTransferFeatureItem(tester);
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

    final nameTextField = find.byWidgetPredicate(
        (widget) => textFieldByLabelTextMatcher(widget, 'Nome completo'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, FULLNAME);

    final accountNumberTextField = find.byWidgetPredicate(
        (widget) => textFieldByLabelTextMatcher(widget, 'Numero da conta'));
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
