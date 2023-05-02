import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';

class AccountInfoTile extends StatelessWidget {
  final ThemeController themeController = Get.find();

  final String title;
  final String iconAddress;
  final double income;
  final double expense;

  AccountInfoTile(
      {super.key,
      required this.title,
      required this.iconAddress,
      required this.income,
      required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: SvgPicture.asset(
              iconAddress,
              color: themeController.isDarkMode.value
                  ? AppColors.newTransactionIconColorDark
                  : AppColors.newTransactionIconColorLight,
              height: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.titleTextColorDark
                          : AppColors.titleTextColorLight,
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Income:',
                    style: TextStyle(
                        color: AppColors.incomePrimaryColor,
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                  Text(
                    ' $income',
                    style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.subtitleTextColorDark
                            : AppColors.subtitleTextColorLight,
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Expense:',
                    style: TextStyle(
                        color: AppColors.expensePrimaryColor,
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                  Text(
                    ' $expense',
                    style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.subtitleTextColorDark
                            : AppColors.subtitleTextColorLight,
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
