import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class NoTransactionFoundAnimation extends StatelessWidget {
  final ThemeController themeController = Get.find();

  NoTransactionFoundAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
          child: Lottie.asset(
            'assets/animations/no_transaction.json',
          ),
        ),
        Obx(
          (() => Text(
                'No transactions found.',
                style: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark
                      : AppColors.titleTextColorLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )),
        ),
      ],
    );
  }
}
