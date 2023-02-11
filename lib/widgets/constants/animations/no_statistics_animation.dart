import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              top: MediaQuery.of(context).size.height * 0.2, bottom: 50),
          child: Obx(
            (() => themeController.isDarkMode.value
                ? Image.asset(
                    'assets/animations/no_data_dark.gif',
                    width: 300,
                  )
                : Image.asset(
                    'assets/animations/no_data_light.gif',
                    width: 300,
                  )),
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
                  fontSize: 22,
                ),
              )),
        ),
      ],
    );
  }
}
