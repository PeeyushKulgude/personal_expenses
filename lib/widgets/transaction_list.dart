import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_page_controller.dart';
import '../controllers/new_transaction_controller.dart';

class TransactionList extends StatelessWidget {
  TransactionList({super.key});

  final HomePageController homePageController = Get.find();
  final NewTransactionController newTransactionController = Get.put(NewTransactionController());

  @override
  Widget build(BuildContext context) {
    String df = "";
    return Obx(() => SizedBox(
          height: 450,
          child: homePageController.userTransactions.isEmpty
              ? Column(
                  children: <Widget>[
                    const Text(
                      'No transactions added yet!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 79),
                      child: Image.asset(
                        'assets/images/waiting.png',
                        height: 240,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemBuilder: ((context, index) {
                    if (df ==
                        DateFormat('dd/MM/yyyy').format(
                            homePageController.userTransactions[index].date)) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              padding: const EdgeInsets.only(
                                  top: 15, left: 10, right: 10),
                              width: 2,
                              height: MediaQuery.of(context).size.height / 30,
                              alignment: Alignment.topRight,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: homePageController
                                                    .userTransactions[index]
                                                    .type ==
                                                "Expense"
                                            ? const Color.fromARGB(
                                                255, 179, 3, 3)
                                            : const Color.fromARGB(
                                                255, 33, 150, 243),
                                        width: 2)),
                                padding: const EdgeInsets.all(10),
                                child: FittedBox(
                                  child: Text(
                                    "₹${homePageController.userTransactions[index].amount.toString()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: homePageController
                                                  .userTransactions[index]
                                                  .type ==
                                              "Expense"
                                          ? const Color.fromARGB(255, 179, 3, 3)
                                          : const Color.fromARGB(
                                              255, 33, 150, 243),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    homePageController
                                        .userTransactions[index].title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('dd/MM/yyyy').format(
                                            homePageController
                                                .userTransactions[index].date),
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              125, 255, 255, 255),
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        homePageController
                                            .userTransactions[index].category,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              125, 255, 255, 255),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: (() {
                                newTransactionController.currDate.value =
                                    homePageController
                                        .userTransactions[index].date;
                                newTransactionController.accountChoice.value =
                                    homePageController.userTransactions[index]
                                                .account ==
                                            'Cash'
                                        ? 1
                                        : homePageController
                                                    .userTransactions[index]
                                                    .account ==
                                                'UPI'
                                            ? 2
                                            : 3;
                                newTransactionController.typeChoice.value =
                                    homePageController
                                                .userTransactions[index].type ==
                                            'Income'
                                        ? 1
                                        : 2;
                                newTransactionController
                                        .titleController.value.text =
                                    homePageController
                                        .userTransactions[index].title;
                                newTransactionController
                                        .amountController.value.text =
                                    homePageController
                                        .userTransactions[index].amount
                                        .toString();
                                newTransactionController.currCategory.value =
                                    homePageController
                                        .userTransactions[index].category;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        homePageController
                                            .startAddNewTransaction(context));
                                homePageController.deleteTransaction(
                                    homePageController
                                        .userTransactions[index].id as int);
                              }),
                              color: Colors.white,
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                if (homePageController
                                        .userTransactions.length ==
                                    1) {
                                  homePageController.deleteTransaction(
                                      homePageController
                                          .userTransactions[index].id as int);
                                  homePageController.userTransactions.value =
                                      [];
                                } else {
                                  homePageController.deleteTransaction(
                                      homePageController
                                          .userTransactions[index].id as int);
                                }
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.delete_outline_rounded),
                            ),
                          ],
                        ),
                      );
                    } else {
                      df = DateFormat('dd/MM/yyyy').format(
                          homePageController.userTransactions[index].date);
                      return Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height /
                                            100),
                                    height:
                                        MediaQuery.of(context).size.height / 22,
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.white,
                                    ),
                                    child: FittedBox(
                                      child: Text(DateFormat('EEE').format(
                                          homePageController
                                              .userTransactions[index].date)),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(
                                        homePageController
                                            .userTransactions[index].date),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  width: 2,
                                  height:
                                      MediaQuery.of(context).size.height / 30,
                                  alignment: Alignment.bottomCenter,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: homePageController
                                                        .userTransactions[index]
                                                        .type ==
                                                    "Expense"
                                                ? const Color.fromARGB(
                                                    255, 179, 3, 3)
                                                : const Color.fromARGB(
                                                    255, 33, 150, 243),
                                            width: 2)),
                                    padding: const EdgeInsets.all(10),
                                    child: FittedBox(
                                      child: Text(
                                        "₹${homePageController.userTransactions[index].amount.toString()}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: homePageController
                                                      .userTransactions[index]
                                                      .type ==
                                                  "Expense"
                                              ? const Color.fromARGB(
                                                  255, 179, 3, 3)
                                              : const Color.fromARGB(
                                                  255, 33, 150, 243),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        homePageController
                                            .userTransactions[index].title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                homePageController
                                                    .userTransactions[index]
                                                    .date),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  125, 255, 255, 255),
                                              fontSize: 11,
                                            ),
                                          ),
                                          Text(
                                            homePageController
                                                .userTransactions[index]
                                                .category,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  125, 255, 255, 255),
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: (() {
                                    newTransactionController.currDate.value =
                                        homePageController
                                            .userTransactions[index].date;
                                    newTransactionController.accountChoice
                                        .value = homePageController
                                                .userTransactions[index]
                                                .account ==
                                            'Cash'
                                        ? 1
                                        : homePageController
                                                    .userTransactions[index]
                                                    .account ==
                                                'UPI'
                                            ? 2
                                            : 3;
                                    newTransactionController.typeChoice.value =
                                        homePageController
                                                    .userTransactions[index]
                                                    .type ==
                                                'Income'
                                            ? 1
                                            : 2;
                                    newTransactionController
                                            .titleController.value.text =
                                        homePageController
                                            .userTransactions[index].title;
                                    newTransactionController
                                            .amountController.value.text =
                                        homePageController
                                            .userTransactions[index].amount
                                            .toString();
                                    newTransactionController
                                            .currCategory.value =
                                        homePageController
                                            .userTransactions[index].category;
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            homePageController
                                                .startAddNewTransaction(
                                                    context));
                                    homePageController.deleteTransaction(
                                        homePageController
                                            .userTransactions[index].id as int);
                                  }),
                                  color: Colors.white,
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (homePageController
                                            .userTransactions.length ==
                                        1) {
                                      homePageController.deleteTransaction(
                                          homePageController
                                              .userTransactions[index]
                                              .id as int);
                                      homePageController
                                          .userTransactions.value = [];
                                    } else {
                                      homePageController.deleteTransaction(
                                          homePageController
                                              .userTransactions[index]
                                              .id as int);
                                    }
                                  },
                                  color: Colors.white,
                                  icon:
                                      const Icon(Icons.delete_outline_rounded),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  itemCount: homePageController.userTransactions.length,
                ),
        ));
  }
}
