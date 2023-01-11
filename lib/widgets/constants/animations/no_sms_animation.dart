import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class NoSMSFoundAnimation extends StatelessWidget {
  final ThemeController themeController = Get.find();

  NoSMSFoundAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          child: Obx(
            (() => themeController.isDarkMode.value
                ? Image.asset(
                    'assets/animations/sms_loading_dark.gif',
                    height: 500,
                    width: 500,
                  )
                : Image.asset(
                    'assets/animations/sms_loading_light.gif',
                    height: 500,
                    width: 500,
                  )),
          ),
        ),
        Positioned(
          top: 400,
          left: MediaQuery.of(context).size.width * 0.1,
          child: Text(
            'No transaction messages found.',
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
