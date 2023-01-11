import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class NoStatisticsAnimation extends StatelessWidget {
  final ThemeController themeController = Get.find();

  NoStatisticsAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          child: Obx(
            (() => themeController.isDarkMode.value
                ? Image.asset(
                    'assets/animations/no_data_dark.gif',
                    height: 500,
                    width: 500,
                  )
                : Image.asset(
                    'assets/animations/no_data_light.gif',
                    height: 500,
                    width: 500,
                  )),
          ),
        ),
        Positioned(
          top: 350,
          left: MediaQuery.of(context).size.width * 0.25,
          child: Text(
            'No data for analysis',
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }
}
