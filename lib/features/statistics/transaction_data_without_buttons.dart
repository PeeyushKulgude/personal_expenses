import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/home_page_controller.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../database/icons_database.dart';
import '../../models/transaction.dart';
import '../../themes/app_colors.dart';

class TransactionDataWithoutButtons extends StatelessWidget {
  final Transaction transaction;
  TransactionDataWithoutButtons(this.transaction, {super.key});

  final HomePageController homePageController = Get.find();
  final NewTransactionController newTransactionController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: transaction.type == "Expense"
                ? Icon(
                    Icons.arrow_drop_up_sharp,
                    color: AppColors.upArrowColor,
                  )
                : Icon(
                    Icons.arrow_drop_down_sharp,
                    color: AppColors.downArrowColor,
                  ),
          ),
          SizedBox(
            width: 100,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 15, left: 3),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: transaction.type == "Expense"
                    ? AppColors.expenseBackgroundColor
                    : AppColors.incomeBackgroundColor,
                border: Border.all(
                    color: transaction.type == "Expense"
                        ? AppColors.expenseBorderColor
                        : AppColors.incomeBorderColor,
                    width: 1),
              ),
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: Text(
                  "₹${transaction.amount.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: transaction.type == "Expense"
                        ? AppColors.expensePrimaryColor
                        : AppColors.incomePrimaryColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction.title,
                  style: TextStyle(
                    fontSize: 18,
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: MediaQuery.of(context).size.height * 0.02,
                      CategoryIcons.iconData[transaction.iconCode]!,
                      color: themeController.isDarkMode.value
                          ? AppColors.subtitleTextColorDark
                          : AppColors.subtitleTextColorLight,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      transaction.category,
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.subtitleTextColorDark
                            : AppColors.subtitleTextColorLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}