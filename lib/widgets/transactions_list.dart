import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transactions.dart';

class TransactionIn extends StatelessWidget {
  final List<Transaction> tran;
  final Function deleteTx;
  TransactionIn(this.tran, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: tran.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'There are no Transactions yet',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(width: 20),
                  Container(
                      height: 200,
                      child: Image.asset('assets/images/expenses_pic1.png'))
                ],
              )
            : ListView.builder(
                itemCount: tran.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              FittedBox(child: Text('\$${tran[index].amount}')),
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        '${tran[index].title}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          Text(DateFormat.yMMMd().format(tran[index].date)),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => deleteTx(tran[index].id),
                      ),
                    ),
                  );
                },
              ));
  }
}
