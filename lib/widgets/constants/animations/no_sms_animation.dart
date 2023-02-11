import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: Lottie.asset(
              'assets/animations/no_sms.json',
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
