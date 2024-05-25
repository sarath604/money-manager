import 'package:flutter/material.dart';
import 'package:money_management/category/Category_add_popup.dart';
import 'package:money_management/category/screen_category.dart';
import 'package:money_management/main.dart';
import 'package:money_management/sreens/widget/bottam_navigation.dart';
import 'package:money_management/transactions/add_transactions.dart';
import 'package:money_management/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedindex = ValueNotifier(0);
  final _page = const [ScreenTransaction(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: Image.asset(
          'C:/Users/pro/Desktop/New folder/money_management/assets/1715927131801-removebg-preview.png',
        ),
        title: const Text('MONEY MANAGER'),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      bottomNavigationBar: const moneymanagerbottamnavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindex,
          builder: (BuildContext context, int updatedindex, _) {
            return _page[updatedindex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedindex.value == 0) {
           // print('add teansaction');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routename);
          } else {
          //  print('add category');

            ShowCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: appcolor,
      ),
    );
  }
}
