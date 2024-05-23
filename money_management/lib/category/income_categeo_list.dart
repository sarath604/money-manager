import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/main.dart';
import 'package:money_management/models/category/category_models.dart';

class incomecategorylist extends StatelessWidget {
  const incomecategorylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategorylist,
      builder: (BuildContext ctx, List<CategoryModels>newlist, Widget? _){
        return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        final category = newlist[index];
        return Card(
          elevation: 5,
          child: ListTile(
            title: Text(category.name),
            trailing: IconButton(
              onPressed: () {
                CategoryDb.instance.deleteCategory(category.id);
              },
              icon: const Icon(Icons.delete_outline),
             color: appcolor,
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
}
