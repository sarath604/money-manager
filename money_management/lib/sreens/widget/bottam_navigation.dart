import 'package:flutter/material.dart';
import 'package:money_management/main.dart';
import 'package:money_management/sreens/sreen_home.dart';

class moneymanagerbottamnavigation extends StatelessWidget {
  const moneymanagerbottamnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedindex,
      builder: (context, updatedvalue, child) {
        return BottomNavigationBar(
         selectedItemColor: Colors.white,
         backgroundColor: appcolor,
          
            currentIndex: updatedvalue,
            
            onTap: (newindex) {
              ScreenHome.selectedindex.value = newindex;
            },
            items: const[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
            ]);
      },
    );
  }
}
