import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';

class TextInputFields extends StatelessWidget {
  TextInputFields({super.key});
  final NewTransactionController c = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          TextField(
            controller: c.titleController.value,
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: themeController.isDarkMode.value
                      ? AppColors.newTransactionTextFieldColorDark
                      : AppColors.newTransactionTextFieldColorLight,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: themeController.isDarkMode.value
                      ? AppColors.newTransactionTextFieldColorDark
                      : AppColors.newTransactionTextFieldColorLight,
                ),
              ),
              labelText: 'Title',
              labelStyle: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: c.amountController.value,
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: themeController.isDarkMode.value
                      ? AppColors.newTransactionTextFieldColorDark
                      : AppColors.newTransactionTextFieldColorLight,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: themeController.isDarkMode.value
                      ? AppColors.newTransactionTextFieldColorDark
                      : AppColors.newTransactionTextFieldColorLight,
                ),
              ),
              labelText: 'Amount',
              labelStyle: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
