import 'package:first_project/models/Contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    },
    version: 1,
  );
}

Future<int> save(Contato contato) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> contactMap = Map();

  contactMap['name'] = contato.nome;
  contactMap['account_number'] = contato.numeroConta;
  return db.insert('contacts', contactMap);
}

Future<List<Contato>> findAll() async {
  final List<Contato> contacts = List();
  final Database db = await getDatabase();

  for (Map<String, dynamic> row in await db.query('contacts')) {
    final Contato contact = Contato(
      row['id'],
      row['name'],
      row['account_number'],
    );
    contacts.add(contact);
  }
  return contacts;
}
