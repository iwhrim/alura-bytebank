import 'package:first_project/models/Contato.dart';

class Transaction {
  final double value;
  final Contato contact;

  Transaction(
      this.value,
      this.contact,
      );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }
}