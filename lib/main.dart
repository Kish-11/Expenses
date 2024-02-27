import 'package:expenses/widgets/chart..dart';
import 'package:expenses/widgets/newTransaction.dart';
import 'package:flutter/material.dart';
import './models/Transactions.dart';
import './widgets/chart..dart';
import './widgets/transactions_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(color: Colors.amber)),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final List<Transaction> userTransaction = [];
  void addNewTransaction(String txTitle, double amt, DateTime chosenDate) {
    final nTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: amt,
        date: chosenDate);

    setState(() {
      userTransaction.add(nTx);
    });
  }

  List<Transaction> get _recentTransaction {
    return userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return NewTransation(addNewTransaction);
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      title: Text(
        'Expenses',
        style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.combine([
              TextDecoration.underline,
            ])),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => startNewTransaction(context),
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.infinity,
                  child: Card(
                    shape: OvalBorder(side: BorderSide.none),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Chart!',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    elevation: 20,
                    color: Colors.orange.shade100,
                  )),
              Chart(_recentTransaction),
              SizedBox(
                height: 20,
              ),
              TransactionIn(userTransaction, deleteTransaction)
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          color: Colors.black,
          Icons.add,
        ),
        onPressed: () => startNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
