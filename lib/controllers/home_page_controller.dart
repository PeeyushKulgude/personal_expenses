import 'package:get/get.dart';
import '../models/transaction.dart';
import '../database/transaction_database.dart';
import 'package:flutter/material.dart';
import '../widgets/new_transaction/new_transaction.dart';
import 'theme_controller.dart';
import '../themes/app_colors.dart';

class HomePageController extends GetxController {
  var userTransactions = <Transaction>[].obs;
  var datewiseGroupedTransactions = <Map<String, dynamic>>[].obs;
  var categoryWiseList = <String, double>{}.obs;
  final ThemeController themeController = Get.put(ThemeController());

  HomePageController() {
    getDatewiseGroupedTransactions();
    refreshTransactions();
    findCategorySum();
  }

  Future refreshTransactions() async {
    var list = (await TransactionDatabase.instance.readAllTransactions());
    if (list != null) {
      userTransactions.value = list;
    }
  }

  Future getDatewiseGroupedTransactions() async {
    var list = (await TransactionDatabase.instance.datewiseTransactions());
    datewiseGroupedTransactions.value = list;
  }

  Future getDatewiseGroupedTransactionsFuture() async {
    var list = (await TransactionDatabase.instance.datewiseTransactions());
    return list;
  }

  List<Transaction> get recentTransactions {
    return userTransactions.where(
      (element) {
        return element.date.isAfter(DateTime.now()
            .subtract(Duration(days: DateTime.now().day.toInt())));
      },
    ).toList();
  }

  void addTx(transaction) async {
    await TransactionDatabase.instance.create(transaction);
    getDatewiseGroupedTransactions();
    refreshTransactions();
  }

  void deleteTransaction(int id) async {
    await TransactionDatabase.instance.delete(id);
    getDatewiseGroupedTransactions();
    refreshTransactions();
  }

  void findCategorySum() async {
    var list = (await TransactionDatabase.instance.findCategorySum());
    if (list != null) {
      for (int i = 0; i < list.length; i++) {
        categoryWiseList[list[i]['category'] as String] =
            (list[i]['SUM (amount)'] as int).toDouble();
      }
    }
  }

  Widget startAddNewTransaction(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SingleChildScrollView(
          child: AlertDialog(
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
            actions: <Widget>[NewTransaction(addTx)],
          ),
        ),
      ),
    );
  }

  Map<String, double> get groupedTransactionValuesMonthly {
    var totalIncome = 0.0;
    var totalExpense = 0.0;
    for (int i = 0; i < recentTransactions.length; i++) {
      if (recentTransactions[i].type == "Expense") {
        totalExpense += recentTransactions[i].amount;
      } else {
        totalIncome += recentTransactions[i].amount;
      }
    }
    return {'expense': totalExpense, 'income': totalIncome};
  }
}
