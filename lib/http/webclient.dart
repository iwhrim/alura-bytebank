import 'dart:convert';
import 'dart:io';

import 'package:first_project/models/Contato.dart';
import 'package:first_project/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

const String baseURL = 'http://192.168.100.220:8080/transactions';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

Future<List<Transaction>> findAll() async {

  final Response response =
      await client.get(baseURL).timeout(Duration(seconds: 5));
  final List<dynamic> decodeJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();

  for (Map<String, dynamic> transactionJson in decodeJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contato(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.nome,
      'accountNumber': transaction.contact.numeroConta
    }
  };

  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(baseURL, headers: {
    'Content-type' : 'application/json',
    'password' : '1000'
  }, body: transactionJson);

  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['value'],
    Contato(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}