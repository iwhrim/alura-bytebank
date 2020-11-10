import 'package:first_project/database/app_database.dart';
import 'package:first_project/models/Contato.dart';
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
                    final int accountNumber = int.tryParse(_controladorNumeroConta.text);
                    final Contato newContact = Contato(0, name, accountNumber);
                    save(newContact).then((id) => Navigator.pop(context));
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
}
