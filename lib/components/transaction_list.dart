import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpenses/Models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((tr) {
        return Card(
          elevation: 5,
          child: Row(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.purple[200],
                child: Text(
                  'R\$' + tr.value.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black),
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
    );
  }
}
