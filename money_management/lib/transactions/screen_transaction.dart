import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/main.dart';
import 'package:money_management/models/category/category_models.dart';
import 'package:money_management/models/transactions/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionlistNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            final _value = newlist[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      TransactionDb.instance.deleteTransaction(_value.Id!);
                    },
                    icon: Icons.delete,
                    label: 'delete',
                   backgroundColor: appcolor,
                  
                  )
                ],
              ),
              key: Key(_value.Id!),
              child: Card(
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Text(
                      parsedate(_value.date),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),

                    backgroundColor: _value.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text('RS ${_value.Amount}'),
                  subtitle: Text(_value.Purpose,style:const TextStyle(color: Colors.black),),
                  trailing: Text(_value.category.name,style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: newlist.length,
        );
      },
    );
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _spliteddate = _date.split(' ');

    return '${_spliteddate.last}\n ${_spliteddate.first}';
    // return '${date.day}\n${date.month}';
  }
}
