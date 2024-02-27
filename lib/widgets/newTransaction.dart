import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransation extends StatefulWidget {
  final Function utx;
  NewTransation(this.utx);

  @override
  State<NewTransation> createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  void onSubmitted() {
    widget.utx(titleController.text, double.parse(amountController.text),
        _selectedDate);
    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Title'),
          controller: titleController,
          onSubmitted: (_) => onSubmitted(),
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Amount'),
          controller: amountController,
          onSubmitted: (_) => onSubmitted(),
        ),
        Row(
          children: [
            Text(
              _selectedDate == null
                  ? 'No Dates Chosen'
                  : 'Picked Date:${DateFormat.yMMMd().format(_selectedDate)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 120,
            ),
            TextButton(
                onPressed: datePicker,
                child: Text(
                  'Choose a Date!',
                  style: TextStyle(
                      fontSize: 15, decoration: TextDecoration.underline),
                ))
          ],
        ),
        ElevatedButton(onPressed: onSubmitted, child: Text('Add transaction'))
      ]),
    );
  }
}
