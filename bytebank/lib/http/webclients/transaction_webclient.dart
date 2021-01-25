import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:bytebank/models/Transiction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));

    List<Transaction> transactions = _toTransactions(response);

    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson,
    );

    Transaction newTransaction = _toTransaction(response);

    return newTransaction;
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);

    return Transaction.fromJson(json);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<Transaction> transactions = List();

    final List<dynamic> decodedJson = jsonDecode(response.body);

    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }
}
