import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import '../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';

class AddTransaction extends StatelessWidget {
  Function aT;
  AddTransaction(this.aT, {super.key});

  final NewTransactionController c = Get.find();

  void wrongInputDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              side: BorderSide(color: Colors.white)),
          backgroundColor: Colors.black,
          title:
              const Text('Wrong Input!', style: TextStyle(color: Colors.white)),
          content: const Text(
            "Some fields might have invalid values or may not be chosen at all.",
            style: TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Okay',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }),
    );
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
          final enteredAmount = double.tryParse(c.amountController.value.text);

          if (enteredTitle == '') {
            c.titleController.value.text = c.currCategory.value;
          }

          if (enteredAmount == null ||
              enteredAmount <= 0 ||
              c.accountChoice.value == 0 ||
              c.typeChoice.value == 0 ||
              c.currCategory.value == '') {
            wrongInputDialog(context);
            return;
          } else {
            aT(Transaction(
              title: c.titleController.value.text,
              amount: int.parse(enteredAmount.toString()),
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
            Navigator.pop(context);
            return;
          }
        }),
        child: const Text(
          "Add Transaction",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
