import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpenses/Models/Transation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = {
    Transaction(
      id: 't1',
      title: 'Novo tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desesas pessoais'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              child: Text(
                'Gráfico',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Colors.purple[200],
            ),
            Column(
              children: _transactions.map((tr) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.green[200],
                        child: Text(
                          'R\$' + tr.value.toString(),
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                        onPressed: null,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            DateFormat('d/MMM/yy').format(tr.date),
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Titulo'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Valor (R\$'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: null,
                          child: Text('Adicionar Transacao'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
