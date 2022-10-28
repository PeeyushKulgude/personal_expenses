import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValuesWeekly {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year && recentTransactions[i].type == "Expense") {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  Map<String, double> get groupedTransactionValuesMonthly {
    var totalIncome = 0.0;
    var totalExpense = 0.0;
    for (int i = 0; i < recentTransactions.length; i++) {
      if (recentTransactions[i].type == "Expense") {
        totalExpense += recentTransactions[i].amount;
      } else {
        totalIncome += recentTransactions[i].amount;
      }
    }
    return {'expense': totalExpense, 'income': totalIncome};
  }

  double get totalSpending {
    return groupedTransactionValuesWeekly.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 14, 14, 14),
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValuesWeekly.map(
              (data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'] as String,
                    data['amount'] as double,
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  ),
                );
              },
            ).toList(),
          ),
        ),
        Row(
          children: const [
            Expanded(
              child: Center(
                child: Text(
                  'Income',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Expense',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Total',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  groupedTransactionValuesMonthly['income']!.toStringAsFixed(2),
                  style:
                      const TextStyle(color: Color.fromARGB(255, 33, 150, 243)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  groupedTransactionValuesMonthly['expense']!.toStringAsFixed(2),
                  style: const TextStyle(color: Color.fromARGB(255, 179, 3, 3)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  (groupedTransactionValuesMonthly['income']! -
                          groupedTransactionValuesMonthly['expense']!)
                      .toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
