import 'package:get/get.dart';
import '../models/transaction.dart';
import '../database/transaction_database.dart';
import 'package:flutter/material.dart';
import '../widgets/new_transaction/new_transaction.dart';

class HomePageController extends GetxController {
  var userTransactions = <Transaction>[].obs;
  var categoryWiseList = <String, double>{}.obs;
  var isLoading = false.obs;

  HomePageController() {
    refreshTransactions();
    findCategorySum();
  }

  Future refreshTransactions() async {
    isLoading.value = true;
    var list = (await TransactionDatabase.instance.readAllTransactions());
    if (list != null) {
      userTransactions.value = list;
    }
    isLoading.value = false;
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
    refreshTransactions();
  }

  void deleteTransaction(int id) async {
    await TransactionDatabase.instance.delete(id);
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                side: BorderSide(color: Colors.white)),
            backgroundColor: Colors.black,
            actions: <Widget>[NewTransaction(addTx)],
          ),
        ),
      ),
    );
  }
}
