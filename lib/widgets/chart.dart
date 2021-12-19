import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransations;
  const Chart(this._recentTransations, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double amount = 0.0;
      _recentTransations.forEach((trans) {
        if (trans.date.day == weekday.day &&
            trans.date.month == weekday.month &&
            trans.date.year == weekday.year) {
          amount += trans.amount;
        }
      });

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  double get totalamount {
    return groupedTransactionValues.fold(0.0, (total, item) {
      return total + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((trans) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  trans['amount'],
                  totalamount == 0.0
                      ? 0.0
                      : (trans['amount'] as double) / totalamount,
                  trans['day']),
            );
          }).toList(),
        ),
      ),
    );
  }
}
