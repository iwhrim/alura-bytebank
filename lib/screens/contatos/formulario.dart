import 'package:first_project/database/dao/contato_dao.dart';
import 'package:first_project/models/contact.dart';
import 'package:first_project/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContatosFormulario extends StatefulWidget {

  @override
  _ContatosFormularioState createState() => _ContatosFormularioState();
}

class _ContatosFormularioState extends State<ContatosFormulario> {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorNumeroConta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _controladorNome,
                decoration: InputDecoration(labelText: 'Nome completo'),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _controladorNumeroConta,
                decoration: InputDecoration(labelText: 'Numero da conta'),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  onPressed: () {
                    final String name = _controladorNome.text;
                    final int accountNumber =
                        int.tryParse(_controladorNumeroConta.text);
                    final Contact newContact = Contact(0, name, accountNumber);
                    _save(dependencies.contatoDAO, newContact, context);
                  },
                  child: Text('Salvar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(ContatoDAO contatoDAO, Contact newContact, BuildContext context) async {
    await contatoDAO.save(newContact);
    Navigator.pop(context);
  }
}
