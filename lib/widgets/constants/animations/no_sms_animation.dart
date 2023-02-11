import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class NoSMSFoundAnimation extends StatelessWidget {
  final ThemeController themeController = Get.find();

  NoSMSFoundAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.25, bottom: 50),
            child: Obx(
              (() => themeController.isDarkMode.value
                  ? Image.asset(
                      'assets/animations/sms_loading_dark.gif',
                      width: 200,
                    )
                  : Image.asset(
                      'assets/animations/sms_loading_light.gif',
                      width: 200,
                    )),
            ),
          ),
          Obx(
            (() => Text(
                  'No transaction messages found.',
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
      ),
    );
  }
}
