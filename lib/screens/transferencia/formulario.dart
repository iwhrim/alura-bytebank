import 'package:first_project/components/editor.dart';
import 'package:first_project/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando transferencia';

const _rotuloCampoNumeroConta = 'Numero da conta';
const _dicaCampoNumeroConta = '0000';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text(_textoBotaoConfirmar),
              onPressed: () => _criarTransferencia(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criarTransferencia(BuildContext context) {
    final double valor = double.tryParse(_controladorCampoValor.text);
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
