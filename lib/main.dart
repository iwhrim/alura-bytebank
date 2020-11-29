import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Bytebank(
    contatoDAO: ContatoDAO(),
  ));
}

class Bytebank extends StatelessWidget {
  final ContatoDAO contatoDAO;

  Bytebank({@required this.contatoDAO});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Dashboard(contatoDAO: contatoDAO),
    );
  }
}
