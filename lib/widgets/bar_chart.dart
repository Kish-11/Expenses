import 'package:flutter/material.dart';

class Bar_Chart extends StatelessWidget {
  final String day;
  final double amount;
  final double totalSum;
  Bar_Chart(this.day, this.amount, this.totalSum);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(child: Text('\$${amount.toStringAsFixed(0)}')),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: Color.fromRGBO(220, 220, 220, 2),
                      borderRadius: BorderRadius.circular(10))),
              FractionallySizedBox(
                heightFactor: totalSum,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(day)
      ],
    );
  }
}
