import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/controllers/sms_controller.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';

import '../../../themes/app_colors.dart';
import 'category_row.dart';

// ignore: must_be_immutable
class NotificationCategoriesDisplay extends StatelessWidget {
  final SmsController smsController = Get.find();
  final ThemeController themeController = Get.find();
  var incomeList = [];
  var expenseList = [];

  NotificationCategoriesDisplay({super.key}) {
    smsController.getNotificationCategories();
    incomeList = smsController.notificationCategoryList
        .where((element) => element.categoryType == 'Income')
        .toList();
    expenseList = smsController.notificationCategoryList
        .where((element) => element.categoryType == 'Expense')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Text(
            'Categories that show up in notifications',
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
              fontSize: 18,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Expense Categories',
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.subtitleTextColorDark
                    : AppColors.subtitleTextColorLight,
                fontSize: 13,
              ),
            ),
            Text(
              'Income Categories',
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.subtitleTextColorDark
                    : AppColors.subtitleTextColorLight,
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      expenseList.length, (index) => NotificationCategoryRow(expenseList[index])),
                ),
              ),
              VerticalDivider(
                thickness: 1,
                color: themeController.isDarkMode.value
                    ? AppColors.cardBorderSideColorDark.withOpacity(1)
                    : AppColors.cardBorderSideColorLight,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      incomeList.length, (index) => NotificationCategoryRow(incomeList[index])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
