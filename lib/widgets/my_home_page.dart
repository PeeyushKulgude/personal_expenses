import 'package:flutter/material.dart';
import 'chart.dart';
import 'transaction_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/home_page_controller.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  final HomePageController c = Get.put(HomePageController());

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      appBar: AppBar(
        title: const Text(
          'Personal Expenses',
        ),
        backgroundColor: const Color.fromARGB(255, 179, 3, 3),
      ),
      drawer: const NavigationDrawer(),
      body: Obx((() => SingleChildScrollView(
            child: c.isLoading.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 120,
                    child: Center(
                        child: LoadingAnimationWidget.beat(
                            color: Colors.white, size: 50)),
                  )
                : Column(
                    children: <Widget>[
                      Chart(c.recentTransactions),
                      TransactionList(),
                    ],
                  ),
          ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 45,
        width: 150,
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          backgroundColor: const Color.fromARGB(255, 33, 150, 243),
          onPressed: (() {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    c.startAddNewTransaction(context));
          }),
          child: const Text(
            "+ Add Transaction",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
