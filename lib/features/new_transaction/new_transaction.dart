import '../../models/sms.dart';
import 'category_select/category_select.dart';
import 'text_fields.dart';
import 'date_choice.dart';
import 'account_choice.dart';
import 'type_choice.dart';
import 'add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../themes/app_colors.dart';
import '../../controllers/theme_controller.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final int editing;
  final SMS? sms;
  NewTransaction(this.addTx, this.editing, this.sms, {super.key});

  final NewTransactionController c = Get.put(NewTransactionController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.01),
            child: Text(
              editing == 0 ? 'New Transaction' : 'Edit Transaction',
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
                fontSize: 18,
              ),
            ),
          ),
          TextInputFields(),
          const CategorySelect(),
          DateChoice(),
          AccountChoice(),
          TypeChoice(),
          AddTransaction(addTx, editing, sms),
        ],
      ),
    );
  }
}
