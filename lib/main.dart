import 'package:first_project/screens/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/bytebank_theme.dart';

void main() {
  runApp(Bytebank());
}



class LogObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print("${cubit.runtimeType} > $change");
    super.onChange(cubit, change);
  }
}

class Bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Bloc.observer = LogObserver();

    return MaterialApp(
      theme: bytebankTheme,
      home: NameContainer(),
    );
  }
}
