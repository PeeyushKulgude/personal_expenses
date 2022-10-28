import 'text_fields.dart';
import 'date_choice.dart';
import 'account_choice.dart';
import 'type_choice.dart';
import 'add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';


class NewTransaction extends StatelessWidget {
  final Function addTx;
  NewTransaction(this.addTx, {super.key});

  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'New Transaction',
                style: TextStyle(
                  color: Color.fromARGB(255, 33, 150, 243),
                  fontSize: 18,
                ),
              ),
            ),
            TextInputFields(),
            DateChoice(),
            AccountChoice(),
            TypeChoice(),
            AddTransaction(addTx),
          ],
        ),
      ),
    );
  }
}
