import 'dart:convert';

import 'package:first_project/http/webclient.dart';
import 'package:first_project/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseURL);
    final List<dynamic> decodeJson = jsonDecode(response.body);

    return decodeJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseURL,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 200)
      return Transaction.fromJson(jsonDecode(response.body));

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
