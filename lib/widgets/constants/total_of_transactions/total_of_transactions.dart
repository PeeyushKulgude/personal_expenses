import 'package:flutter/material.dart';
import 'package:personal_expenses/controllers/home_page_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../../controllers/theme_controller.dart';
import 'package:get/get.dart';

class TotalOfTransactions extends StatelessWidget {

  TotalOfTransactions({super.key});

  final ThemeController themeController = Get.find();
  final HomePageController homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => Container(
            decoration: BoxDecoration(
              color: themeController.isDarkMode.value ? AppColors.cardBackgroundColorDark : AppColors.cardBackgroundColorLight,
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Income',
                          style: TextStyle(
                            color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Expense',
                          style: TextStyle(
                            color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Balance',
                          style: TextStyle(
                            color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 160,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          homePageController.incomeAndExpenseMonthlyTotal['income']!.toStringAsFixed(2),
                          style: TextStyle(
                            color: AppColors.incomeBorderColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          homePageController.incomeAndExpenseMonthlyTotal['expense']!.toStringAsFixed(2),
                          style: TextStyle(
                            color: AppColors.expenseBorderColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          (homePageController.incomeAndExpenseMonthlyTotal['income']! - homePageController.incomeAndExpenseMonthlyTotal['expense']!).toStringAsFixed(2),
                          style: TextStyle(
                            color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
