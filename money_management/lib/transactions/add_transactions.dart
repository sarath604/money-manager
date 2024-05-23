import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/main.dart';
import 'package:money_management/models/category/category_models.dart';
import 'package:money_management/models/transactions/transaction_model.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routename = 'add transaction';
  const ScreenaddTransaction({super.key});

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selecteddate;
  CategoryType? _selectedCategorytype;
  CategoryModels? _selectedCategorymodel;

  String? _CategoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Purpose',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () async {
                  final selecteddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30 * 10)),
                    lastDate: DateTime.now(),
                  );
                  if (selecteddate == null) {
                    return;
                  } else {
                    print(selecteddate.toString());
                    setState(() {
                      _selecteddate = selecteddate;
                    });
                  }
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: appcolor,
                ),
                label: Text(
                  _selecteddate == null
                      ? 'Select Date'
                      : _selecteddate.toString(),
                  style: TextStyle(color: appcolor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => appcolor),
                        value: CategoryType.income,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                            _CategoryID = null;
                          });
                        },
                      ),
                      const Text('Income')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => appcolor),
                        value: CategoryType.expense,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expense;
                            _CategoryID = null;
                          });
                        },
                      ),
                      const Text('Expense')
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                hint: const Text('Select Category'),
                value: _CategoryID,
                items: (_selectedCategorytype == CategoryType.income
                        ? CategoryDb().incomeCategorylist
                        : CategoryDb().expenseCategorylist)
                    .value
                    .map(
                  (e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedCategorymodel = e;
                      },
                    );
                  },
                ).toList(),
                onChanged: (selectedvalu) {
                  setState(() {
                    _CategoryID = selectedvalu;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => appcolor),
                ),
                onPressed: () {
                  addtransaction();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addtransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    // if (_CategoryID == null) {
    //   return;
    // }
    if (_selecteddate == null) {
      return;
    }
    final _parseamount = double.tryParse(_amountText);
    if (_parseamount == null) {
      return;
    }
    if (_selectedCategorymodel == null) {
      return;
    }
    final _model = TransactionModel(
      Purpose: _purposeText,
      Amount: _parseamount,
      date: _selecteddate!,
      type: _selectedCategorytype!,
      category: _selectedCategorymodel!,
    );
    TransactionDb.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }
}
