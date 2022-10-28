import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var currDate = DateTime.now().obs;
  var accountChoice = 0.obs;
  var typeChoice = 0.obs;
  var titleController = TextEditingController().obs;
  var amountController = TextEditingController().obs;

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
}
