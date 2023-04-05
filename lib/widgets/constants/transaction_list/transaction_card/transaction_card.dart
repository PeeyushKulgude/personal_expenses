import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/constants/transaction_list/transaction_card/date_header.dart';
import 'package:personal_expenses/widgets/constants/transaction_list/transaction_card/expanded_card.dart';
import 'package:personal_expenses/widgets/constants/transaction_list/transaction_card/transaction_data_display.dart';
import '../../../../themes/app_colors.dart';
import '../../../../controllers/theme_controller.dart';
import 'package:get/get.dart';

import 'minimized_card.dart';

class TransactionCard extends StatefulWidget {
  final dynamic groupedTransactions;

  const TransactionCard(this.groupedTransactions, {super.key});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  final ThemeController themeController = Get.find();
  late Widget card = DateTime.now().day == widget.groupedTransactions['date'].day &&
          DateTime.now().month == widget.groupedTransactions['date'].month &&
          DateTime.now().year == widget.groupedTransactions['date'].year
      ? ExpandedTransactionCard(widget.groupedTransactions)
      : MinimizedTransactionCard(widget.groupedTransactions);
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        if (isExpanded) {
          card = MinimizedTransactionCard(widget.groupedTransactions);
          isExpanded = false;
        } else {
          card = ExpandedTransactionCard(widget.groupedTransactions);
          isExpanded = true;
        }
      }),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: card,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(sizeFactor: animation, child: child);
        },
      ),
    );
  }
}
