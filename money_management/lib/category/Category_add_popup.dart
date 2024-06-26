import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/main.dart';
import 'package:money_management/models/category/category_models.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> ShowCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
               style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => appcolor),
                ),
              onPressed: () {
                final _name = _nameEditingController.text;
                if (_name.isEmpty) {
                  return;
                }
                final _type = selectedCategoryNotifier.value;
               final _Category = CategoryModels(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type);
                    CategoryDb.instance.insertCategory(_Category);
                    Navigator.of(ctx).pop();
              },
              child: const Text('Add'),
            ),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({required this.title, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                fillColor: MaterialStateColor.resolveWith(
                            (states) => appcolor),
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                  selectedCategoryNotifier.notifyListeners();
                },
              );
            }),
        Text(title)
      ],
    );
  }
}
