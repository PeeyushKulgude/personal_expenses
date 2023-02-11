import 'package:flutter/material.dart';
import '../../../themes/app_colors.dart';
import '../../../../controllers/theme_controller.dart';
import 'package:get/get.dart';

class TotalOfTransactions extends StatelessWidget {
  final Map<String, double> groupedTransactionValuesMonthly;

  TotalOfTransactions(this.groupedTransactionValuesMonthly, {super.key});

  final ThemeController themeController = Get.find();

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
                          groupedTransactionValuesMonthly['income']!.toStringAsFixed(2),
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
                          groupedTransactionValuesMonthly['expense']!.toStringAsFixed(2),
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
                          (groupedTransactionValuesMonthly['income']! - groupedTransactionValuesMonthly['expense']!).toStringAsFixed(2),
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
