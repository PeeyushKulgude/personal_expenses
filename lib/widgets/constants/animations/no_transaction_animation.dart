import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2, bottom: 30),
          child: Obx(
            (() => themeController.isDarkMode.value
                ? Image.asset(
                    'assets/animations/no_transaction_green_dark.gif',
                    width: 250,
                  )
                : Image.asset(
                    'assets/animations/no_transaction_green_light.gif',
                    width: 250,
                  )),
          ),
        ),
        Obx(
          (() => Text(
                'No transactions.',
                style: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark
                      : AppColors.titleTextColorLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )),
        ),
      ],
    );
  }
}
