import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/constants/transaction_list/transaction_card/expanded_card.dart';
import '../../../../controllers/theme_controller.dart';
import 'package:get/get.dart';

import 'minimized_card.dart';

class TransactionCard extends StatefulWidget {
  final dynamic groupedTransactions;
  final int index;

  const TransactionCard(this.groupedTransactions, this.index, {super.key});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  final ThemeController themeController = Get.find();
  late bool isExpanded;
  late Widget card;

  @override
  void initState() {
    super.initState();
    if (widget.index == 0 || widget.index == 1) {
      isExpanded = true;
      card = ExpandedTransactionCard(widget.groupedTransactions);
    } else {
      isExpanded = false;
      card = MinimizedTransactionCard(widget.groupedTransactions);
    }
  }

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
        duration: const Duration(milliseconds: 215),
        child: card,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(sizeFactor: animation, child: child);
        },
      ),
    );
  }
}
