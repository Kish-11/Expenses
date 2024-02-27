import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transactions_list.dart';
import '../models/Transactions.dart';
import 'package:intl/intl.dart';
import './bar_chart.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get bunchTransaction {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (weekDay.day == recentTransaction[i].date.day &&
            weekDay.month == recentTransaction[i].date.month &&
            weekDay.year == recentTransaction[i].date.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get weekSpending {
    return bunchTransaction.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        shadowColor: Colors.yellow,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: bunchTransaction.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: Bar_Chart(
                    data['day'].toString(),
                    data['amount'] as double,
                    weekSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / weekSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
