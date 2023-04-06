import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

// ignore: must_be_immutable
class MinimizedTransactionCard extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final dynamic groupedTransactions;
  late DateTime date;
  MinimizedTransactionCard(this.groupedTransactions, {super.key}) {
    date = groupedTransactions['date'];
  }

  double getIncome() {
    double income = 0;
    for (var transaction in groupedTransactions['transactions']) {
      if (transaction.type == 'Income') {
        income += transaction.amount;
      }
    }
    return income;
  }

  double getExpense() {
    double expense = 0;
    for (var transaction in groupedTransactions['transactions']) {
      if (transaction.type == 'Expense') {
        expense += transaction.amount;
      }
    }
    return expense;
  }

  List<Widget> getIncomeExpenseWidgets() {
    List<Widget> widgets = [];
    if (getIncome() != 0) {
      widgets.add(
        Icon(
          Icons.arrow_drop_down_sharp,
          color: AppColors.downArrowColor,
        ),
      );
      widgets.add(
        Text(
          '${getIncome()}',
          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.incomePrimaryColor),
        ),
      );
    }
    if (getExpense() != 0) {
      widgets.add(
        Icon(
          Icons.arrow_drop_up_sharp,
          color: AppColors.upArrowColor,
        ),
      );
      widgets.add(
        Text(
          '${getExpense()}',
          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.expensePrimaryColor),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: themeController.isDarkMode.value
            ? const Color.fromARGB(156, 27, 27, 27)
            : const Color.fromRGBO(227, 227, 227, 1),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          side: BorderSide(
              color: themeController.isDarkMode.value
                  ? AppColors.cardBorderSideColorDark
                  : AppColors.cardBorderSideColorLight,
              width: 1),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
                height: MediaQuery.of(context).size.height / 22,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: themeController.isDarkMode.value
                      ? AppColors.dayHeaderContainerBackgroundColorDark
                      : AppColors.dayHeaderContainerBackgroundColorLight,
                  border: Border.all(
                      color: themeController.isDarkMode.value
                          ? AppColors.dayHeaderContainerBorderColorDark
                          : AppColors.dayHeaderContainerBorderColorLight,
                      width: 1),
                ),
                child: FittedBox(
                  child: Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.dayHeaderContainerTextColorDark
                            : AppColors.dayHeaderContainerTextColorLight,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    DateFormat('dd MMM yyyy').format(date),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: themeController.isDarkMode.value
                          ? AppColors.dayHeaderDateTextColorDark
                          : AppColors.dayHeaderDateTextColorLight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 28,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: getIncomeExpenseWidgets(),
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
