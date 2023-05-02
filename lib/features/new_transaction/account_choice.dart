import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';

class AccountChoice extends StatelessWidget {
  AccountChoice({super.key});

  final NewTransactionController c = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Obx(
            () => InkWell(
              onTap: (() => c.accountChoice.value = 1),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: c.accountChoice.value == 1
                      ? AppColors.appBarFillColor
                      : themeController.isDarkMode.value
                          ? AppColors.canvasColorDark
                          : AppColors.canvasColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/cash.svg',
                      color: themeController.isDarkMode.value
                          ? AppColors.newTransactionIconColorDark
                          : AppColors.newTransactionIconColorLight,
                    ),
                    Text(
                      'Cash',
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark.withOpacity(0.7)
                            : AppColors.titleTextColorLight.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Expanded(
          child: Obx(
            () => InkWell(
              onTap: (() => c.accountChoice.value = 2),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: c.accountChoice.value == 2
                      ? AppColors.appBarFillColor
                      : themeController.isDarkMode.value
                          ? AppColors.canvasColorDark
                          : AppColors.canvasColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/upi.svg',
                      color: themeController.isDarkMode.value
                          ? AppColors.newTransactionIconColorDark
                          : AppColors.newTransactionIconColorLight,
                    ),
                    Text(
                      'UPI',
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark.withOpacity(0.7)
                            : AppColors.titleTextColorLight.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Expanded(
          child: Obx(
            () => InkWell(
              onTap: (() => c.accountChoice.value = 3),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: c.accountChoice.value == 3
                      ? AppColors.appBarFillColor
                      : themeController.isDarkMode.value
                          ? AppColors.canvasColorDark
                          : AppColors.canvasColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/debitcard.svg',
                      color: themeController.isDarkMode.value
                          ? AppColors.newTransactionIconColorDark
                          : AppColors.newTransactionIconColorLight,
                    ),
                    Text(
                      'Card',
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark.withOpacity(0.7)
                            : AppColors.titleTextColorLight.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
