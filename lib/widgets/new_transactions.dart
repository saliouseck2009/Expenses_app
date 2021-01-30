import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'new shoes', amount: 68.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'new hat', amount: 29.99, date: DateTime.now())
  ];

  final amountController = TextEditingController();

  final titleController = TextEditingController();

  DateTime _selectedDate;

  void submitData() {
    final titlectl = titleController.text;
    final amountctl = double.parse(amountController.text);
    if (titlectl.isEmpty || amountctl <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(titlectl, amountctl, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType
                      .number, //does not work in iOS instead we use TextInputType.numberWithOptions(decimal=true)
                  onSubmitted: (_) => submitData(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                        textColor: Colors.purple,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: _presentDatePicker)
                  ],
                ),
                RaisedButton(
                    child: Text('add Transaction'),
                    textColor: Theme.of(context).textTheme.button.color,
                    color: Theme.of(context).primaryColor,
                    onPressed: submitData)
              ],
            )),
      ),
    );
  }
}
