import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/categories.dart';
import '../database/categories_database.dart';

class NewTransactionController extends GetxController {
  var currDate = DateTime.now().obs;
  var accountChoice = 0.obs;
  var typeChoice = 0.obs;
  var titleController = TextEditingController().obs;
  var amountController = TextEditingController().obs;
  var currCategory = "".obs;

  var userCategories = <Category>[].obs;

  NewTransactionController() {
    refreshCategories();
  }

  Future refreshCategories() async {
    var list = (await CategoryDatabase.instance.readAllCategories());
    if (list != null) {
      userCategories.value = list;
    }
  }

  void addCategory(Category category) async {
    await CategoryDatabase.instance.create(category);
    refreshCategories();
  }

  void deleteCategory(int id) async {
    await CategoryDatabase.instance.delete(id);
    refreshCategories();
  }

  void presentDatePicker(BuildContext context) {
    showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 179, 3, 3),
              onPrimary: Colors.white,
              onSurface: Colors.redAccent,
            ),
            dialogBackgroundColor: Colors.black,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value != null) {
          currDate.value = value;
        }
        return;
      },
    );
  }

  void startAddCategory(BuildContext context, String title, {int id = 20000}) {
    var categoryController = TextEditingController(text: title);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              side: BorderSide(color: Colors.white)),
          backgroundColor: Colors.black,
          title: const Text('Add A New Category',
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: categoryController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
                    ),
                    labelText: 'New Category',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 33, 150, 243),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (categoryController.text != '') {
                  addCategory(Category(title: categoryController.text));
                  if (userCategories.length == 1) {
                    deleteCategory(id);
                    userCategories.value = [];
                  } else {
                    deleteCategory(id);
                  }
                  Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
