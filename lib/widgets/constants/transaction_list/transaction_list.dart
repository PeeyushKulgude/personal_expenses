import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/widgets/constants/animations/no_transaction_animation.dart';
import 'package:personal_expenses/widgets/constants/transaction_list/transaction_card/transaction_card.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/new_transaction_controller.dart';
import '../../../themes/app_colors.dart';

class TransactionList extends StatelessWidget {
  final NewTransactionController newTransactionController = Get.find();
  final HomePageController homePageController = Get.find();
  final ThemeController themeController = Get.find();

  TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (homePageController) {
        if (homePageController.homePageState.value == HomePageStates.loading) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: themeController.isDarkMode.value
                  ? AppColors.iconColor1Dark
                  : AppColors.iconColor1Light,
              size: 50,
            ),
          );
        } else if (homePageController.homePageState.value == HomePageStates.loaded) {
          return ListView.builder(
            itemCount: homePageController.datewiseGroupedTransactions.length,
            itemBuilder: (context, index) {
              final transaction = homePageController.datewiseGroupedTransactions[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: TransactionCard(transaction, index),
              );
            },
          );
        } else if (homePageController.homePageState.value == HomePageStates.empty) {
          return NoTransactionFoundAnimation();
        } else {
          return NoTransactionFoundAnimation();
        }
      },
    );
  }
}
