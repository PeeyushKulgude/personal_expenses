import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import 'package:personal_expenses/features/appbar/custom_appbar.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.45,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          onPressed: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    homePageController.startAddNewTransaction(context, null));
          }),
          child: const Text(
            "+ Add Transaction",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
