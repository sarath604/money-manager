

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/category/category_models.dart';

const CATEGORY_DB_NAME = 'category-db';

abstract class categorydbfuctions {
  Future<List<CategoryModels>> getcategories();
  Future<void> insertCategory(CategoryModels value);
  Future<void> deleteCategory(String CategoryID);
}

class CategoryDb implements categorydbfuctions {

  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();
  
  factory CategoryDb(){
   return instance;
  }

  ValueNotifier<List<CategoryModels>> incomeCategorylist = ValueNotifier([]);
  ValueNotifier<List<CategoryModels>> expenseCategorylist = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModels value) async {
    final _Categorydb = await Hive.openBox<CategoryModels>(CATEGORY_DB_NAME);
    await _Categorydb.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CategoryModels>> getcategories() async {
    final _Categorydb = await Hive.openBox<CategoryModels>(CATEGORY_DB_NAME);
    return _Categorydb.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getcategories();
    incomeCategorylist.value.clear();
    expenseCategorylist.value.clear();
    Future.forEach(
      _allCategories,
      (CategoryModels category) {
        if (category.type == CategoryType.income) {
          incomeCategorylist.value.add(category);
        } else {
          expenseCategorylist.value.add(category);
        }
      },
    );
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomeCategorylist.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expenseCategorylist.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String CategoryID) async {
   final _CategoryDb = await Hive.openBox<CategoryModels>(CATEGORY_DB_NAME);
   await _CategoryDb.delete(CategoryID);
   refreshUI();
  }
}
