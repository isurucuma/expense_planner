import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final addNewTransaction;

  NewTransaction({this.addNewTransaction, Key? key}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _userSelectedDate;

  void _submitData() {
    String title = _titleController.text;
    double amount = _amountController.text.isEmpty
        ? 0
        : double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _userSelectedDate == null) {
      return;
    }
    widget.addNewTransaction(_titleController.text, amount, _userSelectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((userDate) {
      if (userDate == null) {
        return;
      }
      setState(() {
        _userSelectedDate = userDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: [
                  Text(_userSelectedDate == null
                      ? 'No date choosen'
                      : 'Date selected: ${DateFormat.yMd().format(_userSelectedDate)}'),
                  TextButton(
                      onPressed: _presentDatePicker, child: Text('Choose Date'))
                ],
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  "Add Transaction",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
