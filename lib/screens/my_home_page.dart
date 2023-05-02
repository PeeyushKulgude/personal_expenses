import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import 'package:personal_expenses/features/appbar/custom_appbar.dart';
import '../controllers/new_transaction_controller.dart';
import '../features/total_of_transactions/total_of_transactions.dart';
import '../features/transaction_list/transaction_list.dart';
import '../controllers/home_page_controller.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePageController homePageController = Get.find();
  final NewTransactionController newTransactionController = Get.find();

  final ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: ((context) => homePageController.notificationsPermissionDialog(context)));
      }
    });
    Permission.sms.status.isGranted.then((isAllowed) {
      if (!isAllowed) {
        Future.delayed(
          const Duration(seconds: 3),
          (() => showDialog(
                context: context,
                builder: ((context) => homePageController.smsPermissionDialog(context)),
              )),
        );
      }
    });
  }

  Future<void> _refreshHomePage() async {
    homePageController.incomeAndExpenseForLastMonth();
    homePageController.getDatewiseGroupedTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homePageController) {
      if (homePageController.shouldOpenDialogForAddingTransaction.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          log(homePageController.otherTransactionFromNotificationPayload.toString());
          DateTime date =
              DateTime.parse(homePageController.otherTransactionFromNotificationPayload['date']!);
          newTransactionController.currDate.value = DateTime(date.year, date.month, date.day);
          newTransactionController.accountChoice.value =
              homePageController.otherTransactionFromNotificationPayload['account'] == 'UPI'
                  ? 2
                  : 3;
          newTransactionController.typeChoice.value =
              homePageController.otherTransactionFromNotificationPayload['type'] == 'Income'
                  ? 1
                  : 2;
          newTransactionController.amountController.value.text =
              homePageController.otherTransactionFromNotificationPayload['amount']!;
          showDialog(context: context, builder: ((context) => homePageController.startAddNewTransaction(context, null)));
        });
        homePageController.shouldOpenDialogForAddingTransaction.value = false;
      }
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar('Personal Expenses'),
        drawer: CustomNavigationDrawer(),
        body: RefreshIndicator(
          color: AppColors.appBarFillColor,
          onRefresh: () => _refreshHomePage(),
          child: Stack(
            children: [
              ListView(),
              Column(
                children: <Widget>[
                  TotalOfTransactions(),
                  Expanded(child: TransactionList()),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  homePageController.startAddNewTransaction(context, null),
            );
          }),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
