import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';

class DateChoice extends StatelessWidget {

  final NewTransactionController c = Get.find();

  DateChoice({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      height: 60,
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Obx((() => Text(
              DateFormat('dd/MM/yyyy').format(c.currDate.value).toString(),
              style: const TextStyle(color: Colors.white),
            ))),
          ),
          TextButton(
            onPressed: (() => c.presentDatePicker(context)),
            child: const Text(
              'Choose Date',
              style: TextStyle(
                  color: Color.fromARGB(255, 179, 3, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
