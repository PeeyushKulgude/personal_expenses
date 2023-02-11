import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/widgets/constants/animations/no_transaction_animation.dart';
import 'package:personal_expenses/widgets/constants/chart/chart.dart';
import 'package:personal_expenses/widgets/constants/transaction_list/transaction_card.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/new_transaction_controller.dart';
import '../../../themes/app_colors.dart';

class TransactionList extends StatelessWidget {
  TransactionList({super.key});

  final HomePageController homePageController = Get.find();
  final NewTransactionController newTransactionController = Get.put(NewTransactionController());
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homePageController.getDatewiseGroupedTransactions(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: themeController.isDarkMode.value
                  ? AppColors.iconColor1Dark
                  : AppColors.iconColor1Light,
              size: 50,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        Chart(homePageController.recentTransactions),
                        TransactionCard(transaction),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TransactionCard(transaction),
                  );
                }
              },
            );
          } else {
            return NoTransactionFoundAnimation();
          }
        }
        return NoTransactionFoundAnimation();
      },
    );
  }
}
