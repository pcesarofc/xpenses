import 'package:flutter/material.dart';
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
        primarySwatch: Colors.blue,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              child: Text('Gráfico'),
              color: Colors.blue[100],
            ),
            Column(
              children: _transactions.map((tr) {
                return Row(
                  children: [
                    FloatingActionButton(
                      child: Text(tr.value.toString()),
                      onPressed: null,
                    ),
                    Column(
                      children: [
                        Card(child: Text(tr.title)),
                        Card(child: Text(tr.date.toString())),
                      ],
                    ),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}