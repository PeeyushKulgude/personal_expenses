import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          Container(
            decoration: BoxDecoration(
              color: themeController.isDarkMode.value
                  ? AppColors.canvasColorDark
                  : AppColors.canvasColorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: c.titleController.value,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    'assets/images/description-icon.svg',
                    color: AppColors.appBarFillColor,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                labelText: 'Description (Optional)',
                hintText: 'Set as category name if left empty.',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark.withOpacity(0.7)
                      : AppColors.titleTextColorLight.withOpacity(0.7),
                ),
                hintStyle: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.subtitleTextColorDark
                      : AppColors.subtitleTextColorLight,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            decoration: BoxDecoration(
              color: themeController.isDarkMode.value
                  ? AppColors.canvasColorDark
                  : AppColors.canvasColorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: c.amountController.value,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    'assets/images/amount.svg',
                    color: AppColors.appBarFillColor,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                labelText: 'Amount',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark.withOpacity(0.7)
                      : AppColors.titleTextColorLight.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
