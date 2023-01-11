import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/new_transaction_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class AccountChoice extends StatelessWidget {
  AccountChoice({super.key});

  final NewTransactionController c = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Obx(
            () => IconButton(
              icon: SvgPicture.asset(
                'assets/images/cash.svg',
                color: c.accountChoice.value == 1
                    ? const Color.fromARGB(255, 179, 3, 0)
                    : themeController.isDarkMode.value
                        ? AppColors.newTransactionIconColorDark
                        : AppColors.newTransactionIconColorLight,
              ),
              onPressed: (() => c.accountChoice.value = 1),
              color: Colors.black,
              splashRadius: 1,
            ),
          )),
          Expanded(
              child: Obx((() => IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/upi.svg',
                      color: c.accountChoice.value == 2
                          ? const Color.fromARGB(255, 179, 3, 0)
                          : themeController.isDarkMode.value
                              ? AppColors.newTransactionIconColorDark
                              : AppColors.newTransactionIconColorLight,
                    ),
                    onPressed: (() => c.accountChoice.value = 2),
                    color: Colors.black,
                    splashRadius: 1,
                  )))),
          Expanded(
              child: Obx((() => IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/debitcard.svg',
                      color: c.accountChoice.value == 3
                          ? const Color.fromARGB(255, 179, 3, 0)
                          : themeController.isDarkMode.value
                              ? AppColors.newTransactionIconColorDark
                              : AppColors.newTransactionIconColorLight,
                    ),
                    onPressed: (() => c.accountChoice.value = 3),
                    color: Colors.black,
                    splashRadius: 1,
                  )))),
        ],
      ),
    );
  }
}
