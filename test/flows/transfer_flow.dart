import 'package:first_project/components/response_dialog.dart';
import 'package:first_project/components/transaction_auth_dialog.dart';
import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/http/webclients/transaction_webclient.dart';
import 'package:first_project/main.dart';
import 'package:first_project/models/contact.dart';
import 'package:first_project/models/transaction.dart';
import 'package:first_project/screens/contatos/lista.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:first_project/screens/transaction/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  const String FULLNAME = 'Gnome';
  const int ACCOUNT_NUMBER = 99;

  testWidgets('Transfer to a contact', (tester) async {
    final mockContatoDao = MockContatoDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(Bytebank(
      contatoDAO: mockContatoDao,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final gnomeContact = Contact(0, FULLNAME, ACCOUNT_NUMBER);
    when(mockContatoDao.findAll())
        .thenAnswer((invocation) async => [gnomeContact]);

    await clickOnTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactList);
    expect(contactsList, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Gnome' &&
            widget.contact.accountNumber == 99;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text(FULLNAME);
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text(ACCOUNT_NUMBER.toString());
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, 'Value');
    });
    expect(textFieldValue, findsOneWidget);

    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword =
        find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(FlatButton, 'Cancel');
    expect(cancelButton, findsOneWidget);
    final confirmButton = find.widgetWithText(FlatButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    final transaction = Transaction(null, 200, gnomeContact);
    when(mockTransactionWebClient.save(
            transaction, '1000'))
        .thenAnswer((_) async => transaction);
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(FlatButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);
  });
}
