import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';
import '../transaction_list/transaction_card/date_header.dart';
import 'transaction_data_without_buttons.dart';

class TransactionCardWithoutButtons extends StatelessWidget {
  final dynamic groupedTransactions;
  TransactionCardWithoutButtons(this.groupedTransactions, {super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => Card(
            color: themeController.isDarkMode.value ? const Color.fromARGB(156, 27, 27, 27) : const Color.fromRGBO(227, 227, 227, 1),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              side: BorderSide(color: themeController.isDarkMode.value ? AppColors.cardBorderSideColorDark : AppColors.cardBorderSideColorLight, width: 1),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: List.generate(
                  groupedTransactions['transactions'].length,
                  (index) {
                    if (index == 0) {
                      return Column(
                        children: [DateHeader(groupedTransactions['date']), TransactionDataWithoutButtons(groupedTransactions['transactions'][index])],
                      );
                    } else {
                      return TransactionDataWithoutButtons(groupedTransactions['transactions'][index]);
                    }
                  },
                ),
              ),
            ),
          )),
    );
  }
}
