import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xpenses/components/chart.dart';
import 'package:xpenses/components/transaction_form.dart';
import 'package:xpenses/Models/transaction.dart';
import 'package:xpenses/components/transaction_item.dart';
import 'dart:math';
import 'package:xpenses/components/transaction_list.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final baseUrl = 'https://xpenses-app-1f3ec-default-rtdb.firebaseio.com';
  final List<Transaction> _transactions = [];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    //adiciona uma nova transação
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    http.post(Uri.parse('$baseUrl/transaction.json'),
        body: jsonEncode({
          'id': newTransaction.id,
          'title': newTransaction.title,
          'value': newTransaction.value,
          'date': newTransaction.date,
        }));

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop(); //fecha a aba de inserir os dados
  }

  _removeTransaction(String id) {
    // remove a transação usando o ID como parametro
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    // Seta a variável islandscape como a tela virada
    bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //

    final appBar = AppBar(
      title: Text('Depesas Pessoais'),
      actions: <Widget>[
        //Condicional para  mostrar ou não o botão de mostrar o Chart ou TransactionList
        if (islandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),

        //
      ],
    );

    //Seta o tamanho da altura em 100% excluindo a appbar e a barra de notificações
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    //

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !islandscape)
              Container(
                child: Chart(_recentTransactions),
                height: availableHeight * (islandscape ? 0.8 : 0.3),
              ),
            if (!_showChart || !islandscape)
              Container(
                child: TransactionList(_transactions, _removeTransaction),
                height: availableHeight * (islandscape ? 1 : 0.7),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
