import 'package:first_project/database/app_database.dart';
import 'package:first_project/models/Contato.dart';
import 'package:first_project/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Bytebank());
    findAll().then((contacts) => debugPrint(contacts.toString()));
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
