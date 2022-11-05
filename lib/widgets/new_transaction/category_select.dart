import 'package:flutter/material.dart';
import '../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';

class CategorySelect extends StatelessWidget {
  CategorySelect({super.key});

  final NewTransactionController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          DropdownButton(
            hint: c.currCategory.value == ""
                ? const Text(
                    'Select Category',
                    style: TextStyle(color: Color.fromARGB(100, 255, 255, 255)),
                  )
                : Text(
                    c.currCategory.value,
                    style: const TextStyle(color: Colors.white),
                  ),
            dropdownColor: const Color.fromARGB(255, 14, 14, 14),
            iconEnabledColor: Colors.white,
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: const Color.fromARGB(255, 33, 150, 243),
            ),
            onChanged: ((value) => c.currCategory.value = value as String),
            items: List.generate(
              c.userCategories.length,
              (index) {
                return DropdownMenuItem(
                  value: c.userCategories[index].title,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            c.userCategories[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            c.startEditCategory(
                                context, c.userCategories[index].title,
                                c.userCategories[index].id as int);
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            if (c.userCategories.length == 1) {
                              c.deleteCategory(
                                  c.userCategories[index].id as int);
                              Navigator.of(context).pop();
                              c.userCategories.value = [];
                            } else {
                              c.deleteCategory(
                                  c.userCategories[index].id as int);
                              Navigator.of(context).pop();
                            }
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
              onPressed: () => c.startAddCategory(context),
              icon: const Icon(Icons.add),
              color: Colors.white),
        ],
      ),
    );
  }
}
