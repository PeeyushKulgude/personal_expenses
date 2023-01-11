import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/new_transaction_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class TypeChoice extends StatelessWidget {
  TypeChoice({super.key});

  final NewTransactionController c = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Income',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.titleTextColorDark
                          : AppColors.titleTextColorLight,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Expense',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.titleTextColorDark
                          : AppColors.titleTextColorLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Obx(
                  (() => IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/down-arrow.svg',
                          color: c.typeChoice.value == 1
                              ? AppColors.incomePrimaryColor
                              : themeController.isDarkMode.value
                                  ? AppColors.newTransactionIconColorDark
                                  : AppColors.newTransactionIconColorLight,
                        ),
                        onPressed: (() => c.typeChoice.value = 1),
                        color: Colors.black,
                        splashRadius: 1,
                      )),
                ),
              ),
              Expanded(
                child: Obx(
                  (() => IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/up-arrow.svg',
                          color: c.typeChoice.value == 2
                              ? AppColors.expensePrimaryColor
                              : themeController.isDarkMode.value
                                  ? AppColors.newTransactionIconColorDark
                                  : AppColors.newTransactionIconColorLight,
                        ),
                        onPressed: (() => c.typeChoice.value = 2),
                        color: Colors.black,
                        splashRadius: 1,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
