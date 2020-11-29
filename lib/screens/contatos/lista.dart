import 'package:first_project/components/progress.dart';
import 'package:first_project/models/contact.dart';
import 'package:first_project/screens/contatos/formulario.dart';
import 'package:first_project/screens/transaction/transaction_form.dart';
import 'package:first_project/widgets/app_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: dependencies.contatoDAO.findAll(),
        builder: (context, snapshot) {
          final List<Contact> contacts = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return ContactItem(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    },
                  );
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text('Oops...something not cool happened... :(');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => ContatosFormulario(),
            ),
          )
              .then((value) {
            setState(() {
              widget.createState();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;

  final Function onClick;

  ContactItem(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
