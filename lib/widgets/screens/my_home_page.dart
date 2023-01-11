import 'package:flutter/material.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/widgets/constants/appbar/custom_appbar.dart';
import '../constants/total_of_transactions/total_of_transactions.dart';
import '../constants/transaction_list/transaction_list.dart';
import '../../controllers/home_page_controller.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  final HomePageController homePageController = Get.put(HomePageController());
  final ThemeController themeController = Get.find();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Personal Expenses'),
      drawer: NavigationDrawer(),
      body: Obx(
        (() => SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TotalOfTransactions(
                      homePageController.groupedTransactionValuesMonthly),
                  TransactionList(),
                ],
              ),
            )),
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
