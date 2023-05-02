import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/sms.dart';
import '../models/transaction.dart';
import '../database/transaction_database.dart';
import 'package:flutter/material.dart';
import '../features/new_transaction/new_transaction.dart';
import 'theme_controller.dart';
import '../themes/app_colors.dart';

enum HomePageStates { initial, loading, loaded, error, empty, disabled }

class HomePageController extends GetxController {
  var shouldOpenDialogForAddingTransaction = false.obs;
  var otherTransactionFromNotificationPayload = <String, String>{}.obs;
  var userTransactions = <Transaction>[].obs;
  var datewiseGroupedTransactions = <Map<String, dynamic>>[].obs;
  var incomeAndExpenseMonthlyTotal = <String, double>{'expense': 0, 'income': 0}.obs;
  final ThemeController themeController = Get.put(ThemeController());

  var homePageState = HomePageStates.loading.obs;

  @override
  void onInit() {
    super.onInit();
    getDatewiseGroupedTransactions();
    incomeAndExpenseForLastMonth();
  }

  void addOtherTransactionFromNotification(Map<String, String> payload) {
    shouldOpenDialogForAddingTransaction.value = true;
    otherTransactionFromNotificationPayload.value = payload;
    refresh();
  }

  Future refreshTransactions() async {
    var list = (await TransactionDatabase.instance.readAllTransactions());
    if (list != null) {
      userTransactions.value = list;
      return list;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getDatewiseGroupedTransactions() async {
    homePageState.value = HomePageStates.loading;
    refresh();
    var list = await TransactionDatabase.instance.datewiseTransactions();
    if (list != null) {
      datewiseGroupedTransactions.value = list;
      homePageState.value = HomePageStates.loaded;
      refresh();
      incomeAndExpenseMonthlyTotal();
      return list;
    }
    homePageState.value = HomePageStates.empty;
    refresh();
    return null;
  }

  Future<List<Transaction>?> currentMonthTransactions() async {
    var list = await refreshTransactions();
    final DateTime startOfTheMonth =
        DateTime.now().subtract(Duration(days: DateTime.now().day.toInt()));
    var lst = <Transaction>[];
    if (list != null) {
      for (var element in list!) {
        if (element.date.isAfter(startOfTheMonth)) {
          lst.add(element);
        }
      }
    }
    return lst;
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

  void addTx(transaction) async {
    await TransactionDatabase.instance.create(transaction);
    incomeAndExpenseForLastMonth();
    getDatewiseGroupedTransactions();
  }

  void editTx(transaction) async {
    await TransactionDatabase.instance.update(transaction.id, transaction);
    incomeAndExpenseForLastMonth();
    getDatewiseGroupedTransactions();
  }

  void deleteTransaction(int id) async {
    await TransactionDatabase.instance.delete(id);
    incomeAndExpenseForLastMonth();
    getDatewiseGroupedTransactions();
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
        'Permission To Add Transaction From Notifications (Beta)',
        style: TextStyle(
          color: themeController.isDarkMode.value
              ? AppColors.titleTextColorDark
              : AppColors.titleTextColorLight,
        ),
      ),
      content: Text(
        'Do you want to directly add a transaction from notifications when a transaction is detected via SMS?\nNote: Turn off battery saver to enable working of notifications in the background.',
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
          onPressed: () => Permission.notification.request().then((_) => Navigator.pop(context)),
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
}
