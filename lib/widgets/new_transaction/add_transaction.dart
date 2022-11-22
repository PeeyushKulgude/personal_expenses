import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import '../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';

class AddTransaction extends StatelessWidget {
  Function aT;
  AddTransaction(this.aT, {super.key});

  final NewTransactionController c = Get.find();
  final ThemeController themeController = Get.find();

  void wrongInputDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
                color: themeController.isDarkMode.value
                    ? AppColors.cardBorderSideColorDark
                    : AppColors.cardBorderSideColorLight,
                width: 1),
          ),
          elevation: 10,
          backgroundColor: themeController.isDarkMode.value
              ? AppColors.cardBackgroundColorDark
              : AppColors.cardBackgroundColorLight,
          title: Text('Wrong Input!',
              style: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark
                      : AppColors.titleTextColorLight)),
          content: Text(
            "Some fields might have invalid values or may not be chosen at all.",
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.subtitleTextColorDark
                  : AppColors.subtitleTextColorLight,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Okay',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      padding: const EdgeInsets.only(top: 12),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                  width: 1,
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark
                      : AppColors.titleTextColorLight),
            ),
          ),
        ),
        onPressed: (() {
          String acc = "";
          if (c.accountChoice.value == 1) {
            acc = "Cash";
          } else if (c.accountChoice.value == 2) {
            acc = "UPI";
          } else if (c.accountChoice.value == 3) {
            acc = "DebitCard";
          }

          String currType = "";
          if (c.typeChoice.value == 1) {
            currType = "Income";
          } else if (c.typeChoice.value == 2) {
            currType = "Expense";
          }

          var enteredTitle = c.titleController.value.text;

          if (enteredTitle == '') {
            c.titleController.value.text = c.currCategory.value;
          }
          if (!isInt(c.amountController.value.text) ||
              int.parse(c.amountController.value.text) <= 0 ||
              c.accountChoice.value == 0 ||
              c.typeChoice.value == 0 ||
              c.currCategory.value == '') {
            wrongInputDialog(context);
            return;
          } else {
            DateTime now = c.currDate.value;
            aT(Transaction(
              title: c.titleController.value.text,
              amount: int.parse(c.amountController.value.text),
              date: DateTime(now.year, now.month, now.day),
              type: currType,
              account: acc,
              category: c.currCategory.value,
            ));

            c.accountChoice = 0.obs;
            c.typeChoice = 0.obs;
            c.currCategory = ''.obs;

            c.titleController.value.clear();
            c.amountController.value.clear();
            c.currDate.value = DateTime.now();
            Navigator.pop(context);
            return;
          }
        }),
        child: Text(
          "Add Transaction",
          style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight),
        ),
      ),
    );
  }
}
