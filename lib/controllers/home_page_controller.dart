import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/sms.dart';
import '../models/transaction.dart';
import '../database/transaction_database.dart';
import 'package:flutter/material.dart';
import '../widgets/constants/new_transaction/new_transaction.dart';
import 'theme_controller.dart';
import '../themes/app_colors.dart';

class HomePageController extends GetxController {
  var userTransactions = <Transaction>[].obs;
  var datewiseGroupedTransactions = <Map<String, dynamic>>[].obs;
  var incomeAndExpenseMonthlyTotal = <String, double>{'expense': 0, 'income': 0}.obs;
  final ThemeController themeController = Get.put(ThemeController());

  HomePageController() {
    getDatewiseGroupedTransactions();
    refreshTransactions();
    incomeAndExpenseForLastMonth();
  }

  Future refreshTransactions() async {
    var list = (await TransactionDatabase.instance.readAllTransactions());
    if (list != null) {
      userTransactions.value = list;
      return list;
    }
  }

  Future<List<Map<String, dynamic>>?> getDatewiseGroupedTransactions() async {
    var list = await TransactionDatabase.instance.datewiseTransactions();
    if (list != null) {
      datewiseGroupedTransactions.value = list;
      return list;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getCategoryAndDatewiseTransactions(String categoryName) async {
    var list = await TransactionDatabase.instance.categoryWiseTransactions(categoryName);
    return list!;
  }

  Future<List<Transaction>?> currentMonthTransactions() async {
    var list = await refreshTransactions();
    final DateTime startOfTheMonth =
        DateTime.now().subtract(Duration(days: DateTime.now().day.toInt()));
    var lst = <Transaction>[];
    for (var element in list!) {
      if (element.date.isAfter(startOfTheMonth)) {
        lst.add(element);
      }
    }
    return lst;
  }

  void addTx(transaction) async {
    await TransactionDatabase.instance.create(transaction);
    getDatewiseGroupedTransactions();
    refreshTransactions();
    incomeAndExpenseForLastMonth();
  }

  void editTx(transaction) async {
    await TransactionDatabase.instance.update(transaction.id, transaction);
    getDatewiseGroupedTransactions();
    refreshTransactions();
    incomeAndExpenseForLastMonth();
  }

  void deleteTransaction(int id) async {
    await TransactionDatabase.instance.delete(id);
    getDatewiseGroupedTransactions();
    refreshTransactions();
    incomeAndExpenseForLastMonth();
  }

  Widget startAddNewTransaction(BuildContext context, SMS? sms) {
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
                ? AppColors.alertDialogBackgroundColorDark
                : AppColors.alertDialogBackgroundColorLight,
            actions: <Widget>[NewTransaction(addTx, 0, sms)],
          ),
        ),
      ),
    );
  }

  Widget editTransaction(BuildContext context, int editing) {
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
                ? AppColors.alertDialogBackgroundColorDark
                : AppColors.alertDialogBackgroundColorLight,
            actions: <Widget>[NewTransaction(editTx, editing, null)],
          ),
        ),
      ),
    );
  }

  AlertDialog notificationsPermissionDialog(BuildContext context) {
    return AlertDialog(
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
          ? AppColors.alertDialogBackgroundColorDark
          : AppColors.alertDialogBackgroundColorLight,
      title: Text(
        'Permission To Add Transaction From Notifications',
        style: TextStyle(
          color: themeController.isDarkMode.value
              ? AppColors.titleTextColorDark
              : AppColors.titleTextColorLight,
        ),
      ),
      content: Text(
        'Do you want to directly add a transaction from notifications when a transaction is detected via SMS?',
        style: TextStyle(
          color: themeController.isDarkMode.value
              ? AppColors.subtitleTextColorDark
              : AppColors.subtitleTextColorLight,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Deny',
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
          ),
        ),
        TextButton(
          onPressed: () => AwesomeNotifications()
              .requestPermissionToSendNotifications()
              .then((_) => Navigator.pop(context)),
          child: Text(
            'Allow',
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
          ),
        ),
      ],
    );
  }

  AlertDialog smsPermissionDialog(BuildContext context) {
    return AlertDialog(
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
          ? AppColors.alertDialogBackgroundColorDark
          : AppColors.alertDialogBackgroundColorLight,
      title: Text(
        'Permission To Read SMS',
        style: TextStyle(
          color: themeController.isDarkMode.value
              ? AppColors.titleTextColorDark
              : AppColors.titleTextColorLight,
        ),
      ),
      content: Text(
        'Allow permission to read SMS if you want to add transactions via SMS.',
        style: TextStyle(
          color: themeController.isDarkMode.value
              ? AppColors.subtitleTextColorDark
              : AppColors.subtitleTextColorLight,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Deny',
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Permission.sms.request().then((_) => Navigator.pop(context)),
          child: Text(
            'Allow',
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
          ),
        ),
      ],
    );
  }

  Future<Map<String, double>> incomeAndExpenseForLastMonth() async {
    var totalIncome = 0.0;
    var totalExpense = 0.0;
    var list = await currentMonthTransactions();
    if (list != null) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].type == "Expense") {
          totalExpense += list[i].amount;
        } else {
          totalIncome += list[i].amount;
        }
      }
    }
    incomeAndExpenseMonthlyTotal.value = {'expense': totalExpense, 'income': totalIncome};
    return incomeAndExpenseMonthlyTotal;
  }
}
