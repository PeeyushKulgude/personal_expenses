import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import 'package:personal_expenses/widgets/constants/appbar/custom_appbar.dart';
import '../widgets/constants/total_of_transactions/total_of_transactions.dart';
import '../widgets/constants/transaction_list/transaction_list.dart';
import '../controllers/home_page_controller.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePageController _homePageController = Get.put(HomePageController());

  final ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: ((context) => _homePageController.notificationsPermissionDialog(context)));
      }
    });
    Permission.sms.status.isGranted.then((isAllowed) {
      if (!isAllowed) {
        Future.delayed(
          const Duration(seconds: 3),
          (() => showDialog(
                context: context,
                builder: ((context) => _homePageController.smsPermissionDialog(context)),
              )),
        );
      }
    });
  }

  Future<void> _refreshHomePage() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Personal Expenses'),
      drawer: NavigationDrawer(),
      body: Obx(
        (() => RefreshIndicator(
              color: AppColors.appBarFillColor,
              onRefresh: () => _refreshHomePage(),
              child: Stack(
                children: [
                  ListView(),
                  Column(
                    children: <Widget>[
                      TotalOfTransactions(_homePageController.groupedTransactionValuesMonthly),
                      Expanded(child: TransactionList()),
                    ],
                  ),
                ],
              ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
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
                    _homePageController.startAddNewTransaction(context, null));
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
