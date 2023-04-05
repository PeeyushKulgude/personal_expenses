import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import '../../../../controllers/home_page_controller.dart';
import '../../../../controllers/new_transaction_controller.dart';
import '../../../../database/icons_database.dart';
import '../../../../themes/app_colors.dart';
import '../../../../models/transaction.dart';

class TransactionDataDisplay extends StatelessWidget {
  final Transaction transaction;
  TransactionDataDisplay(this.transaction, {super.key});

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
              margin: const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 3),
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
                FittedBox(
                  child: Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeController.isDarkMode.value
                          ? AppColors.titleTextColorDark
                          : AppColors.titleTextColorLight,
                    ),
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
                    FittedBox(
                      child: Text(
                        transaction.category,
                        style: TextStyle(
                          color: themeController.isDarkMode.value
                              ? AppColors.subtitleTextColorDark
                              : AppColors.subtitleTextColorLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: (() {
              newTransactionController.currDate.value = transaction.date;
              newTransactionController.accountChoice.value = transaction.account == 'Cash'
                  ? 1
                  : transaction.account == 'UPI'
                      ? 2
                      : 3;
              newTransactionController.typeChoice.value = transaction.type == 'Income' ? 1 : 2;
              newTransactionController.titleController.value.text = transaction.title;
              newTransactionController.amountController.value.text = transaction.amount.toString();
              newTransactionController.currCategoryTitle.value = transaction.category;
              newTransactionController.currCategoryIconCode.value = transaction.iconCode;
              newTransactionController.currCategoryType.value = transaction.type;
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      homePageController.editTransaction(context, transaction.id!));
            }),
            color: themeController.isDarkMode.value
                ? AppColors.iconColor1Dark
                : AppColors.iconColor1Light,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              if (homePageController.userTransactions.length == 1) {
                homePageController.deleteTransaction(transaction.id as int);
                homePageController.userTransactions.value = [];
              } else {
                homePageController.deleteTransaction(transaction.id as int);
              }
            },
            color: AppColors.deleteIconColor,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }
}
