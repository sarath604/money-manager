import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_models.dart';
 part 'transaction_model.g.dart';
@HiveType(typeId: 3)
class TransactionModel {
 
  @HiveField(0)
  final String Purpose;
 
  @HiveField(1)
  final double Amount;
 
  @HiveField(2)
  final DateTime date;
 
  @HiveField(3)
  final CategoryType type;
 
  @HiveField(4)
  final CategoryModels category;
  
@HiveField(5)
   String? Id;

  TransactionModel({
    required this.Purpose,
    required this.Amount,
    required this.date,
    required this.type,
    required this.category,
  }){
    Id =DateTime.now().microsecondsSinceEpoch.toString();
  }
}
