import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class NoStatisticsAnimation extends StatelessWidget {
  final ThemeController themeController = Get.find();

  NoStatisticsAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.15,
            bottom: 30,
            left: 25,
          ),
          child: Lottie.asset(
            'assets/animations/no_data.json',
          ),
        ),
        Obx(
          (() => Text(
                'No data for analysis.',
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
