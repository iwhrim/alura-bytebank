import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/http/webclients/transaction_webclient.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {
  final ContatoDAO contatoDAO;
  final TransactionWebClient transactionWebClient;

  AppDependencies({
    @required this.contatoDAO,
    @required this.transactionWebClient,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contatoDAO != oldWidget.contatoDAO || transactionWebClient != oldWidget.transactionWebClient;
  }

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();
}
