import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/app_colors.dart';
import '../../../controllers/theme_controller.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
              child: Text(
            '₹${spendingAmount.toStringAsFixed(0)}',
            style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.subtitleTextColorDark
                    : AppColors.subtitleTextColorLight),
          )),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: themeController.isDarkMode.value
                    ? AppColors.chartBarBorderColorDark
                    : AppColors.chartBarBorderColorLight,
                    width: 1,
                  ),
                  color: themeController.isDarkMode.value
                    ? AppColors.chartBarBackgroundColorDark
                    : AppColors.chartBarBackgroundColorLight,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.expensePrimaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.subtitleTextColorDark
                  : AppColors.subtitleTextColorLight),
        ),
      ],
    );
  }
}
