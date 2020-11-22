import 'package:first_project/http/webclient.dart';
import 'package:first_project/models/Contato.dart';
import 'package:first_project/models/transaction.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Bytebank());
  save(Transaction(200.0, Contato(0, 'Priston Tale', 2000)))
      .then((value) => print(value));
  findAll().then((value) => print(value));
}

class Bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Dashboard(),
    );
  }
}
