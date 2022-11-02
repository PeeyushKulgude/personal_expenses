import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import '../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';

class AddTransaction extends StatelessWidget {
  Function aT;
  AddTransaction(this.aT, {super.key});

  final NewTransactionController c = Get.find();

  void _addTransaction() {
    String acc = "";
    if (c.accountChoice.value == 1) {
      acc = "Cash";
    } else if (c.accountChoice.value == 2) {
      acc = "UPI";
    } else if (c.accountChoice.value == 3) {
      acc = "DebitCard";
    }

    String currType = "";
    if (c.typeChoice.value == 1) {
      currType = "Income";
    } else if (c.typeChoice.value == 2) {
      currType = "Expense";
    }

    var enteredTitle = c.titleController.value.text;
    final enteredAmount = double.parse(c.amountController.value.text);

    if (enteredTitle == '') {
      c.titleController.value.text = c.currCategory.value;
    }

    if (enteredAmount <= 0 ||
        c.accountChoice.value == 0 ||
        c.typeChoice.value == 0 ||
        c.currCategory.value == '') {
      c.accountChoice = 0.obs;
      c.typeChoice = 0.obs;
      c.currCategory = ''.obs;

      c.titleController.value.clear();
      c.amountController.value.clear();
      c.currDate.value = DateTime.now();

      return;
    } else {
      aT(Transaction(
        title: c.titleController.value.text,
        amount: int.parse(c.amountController.value.text),
        date: c.currDate.value,
        type: currType,
        account: acc,
        category: c.currCategory.value,
      ));

      c.accountChoice = 0.obs;
      c.typeChoice = 0.obs;
      c.currCategory = ''.obs;

      c.titleController.value.clear();
      c.amountController.value.clear();
      c.currDate.value = DateTime.now();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      padding: const EdgeInsets.only(top: 12),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(width: 1, color: Colors.white),
            ),
          ),
        ),
        onPressed: (() {
          _addTransaction();
          Navigator.of(context).pop();
        }),
        child: const Text(
          "Add Transaction",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
