import 'package:first_project/database/app_database.dart';
import 'package:first_project/models/Contato.dart';
import 'package:sqflite/sqflite.dart';

class ContatoDAO {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> save(Contato contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contato);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contato.nome;
    contactMap[_accountNumber] = contato.numeroConta;
    return contactMap;
  }

  Future<List<Contato>> findAll() async {
    final Database db = await getDatabase();
    final List<Contato> contacts = List();
    for (Map<String, dynamic> row in await db.query(_tableName)) {
      final Contato contact = Contato(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
