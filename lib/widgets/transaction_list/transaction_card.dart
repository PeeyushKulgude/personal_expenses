import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_list/date_header.dart';
import 'package:personal_expenses/widgets/transaction_list/transaction_data_display.dart';
import '../../themes/app_colors.dart';
import '../../controllers/theme_controller.dart';
import 'package:get/get.dart';

class TransactionCard extends StatelessWidget {
  final groupedTransactions;
  TransactionCard(this.groupedTransactions, {super.key});
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: themeController.isDarkMode.value
          ? const Color.fromARGB(156, 27, 27, 27)
          : const Color.fromRGBO(227, 227, 227, 1),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        side: BorderSide(
            color: themeController.isDarkMode.value
                ? AppColors.cardBorderSideColorDark
                : AppColors.cardBorderSideColorLight,
            width: 1),
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
                  children: [
                    DateHeader(groupedTransactions['date']),
                    TransactionDataDisplay(
                        groupedTransactions['transactions'][index])
                  ],
                );
              } else {
                return TransactionDataDisplay(
                    groupedTransactions['transactions'][index]);
              }
            },
          ),
        ),
      ),
    );
  }
}
