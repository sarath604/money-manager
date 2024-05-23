import 'package:flutter/material.dart';
import 'package:money_management/category/expense_category_list.dart';
import 'package:money_management/category/income_categeo_list.dart';
import 'package:money_management/db/category/category_db.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs:const [
            Tab(
              text: 'INCOME',
            ),
            Tab(text: 'EXPENSE'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller:_tabController ,
            children:const [
             incomecategorylist(),
             expensecategorylist(),
            ],
          ),
        ),
      ],
    );
  }
}
