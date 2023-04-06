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
                  color: AppColors.appBarFillColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appBarFillColor,
                ),
              ),
              labelText: 'Description',
              hintText: 'Set as category name if left empty.',
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
              hintStyle: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.subtitleTextColorDark
                    : AppColors.subtitleTextColorLight,
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
                  color: AppColors.appBarFillColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appBarFillColor,
                ),
              ),
              labelText: 'Amount',
              alignLabelWithHint: true,
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
