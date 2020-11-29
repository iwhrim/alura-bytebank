import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/http/webclients/transaction_webclient.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:first_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Bytebank(
    contatoDAO: ContatoDAO(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class Bytebank extends StatelessWidget {
  final ContatoDAO contatoDAO;
  final TransactionWebClient transactionWebClient;

  Bytebank({
    @required this.contatoDAO,
    @required this.transactionWebClient,
  });

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contatoDAO: contatoDAO,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Dashboard(),
      ),
    );
  }
}
