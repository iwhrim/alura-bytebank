import 'package:first_project/screens/counter.dart';
import 'package:flutter/material.dart';
import 'components/bytebank_theme.dart';

void main() {
  runApp(Bytebank());
}

class Bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: bytebankTheme,
      home: CounterPage(),
    );
  }
}
