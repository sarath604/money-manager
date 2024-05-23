import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/transactions/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getallTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionlistNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.Id, obj);
  }

  Future<void> refresh() async {
    final list = await getallTransaction();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionlistNotifier.value.clear();
    transactionlistNotifier.value.addAll(list);
    transactionlistNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getallTransaction() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await _db.delete(id);
   refresh();
  }
}
