import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/controllers/statistics_controller.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import '../../controllers/theme_controller.dart';

class CustomPieChart extends StatelessWidget {
  CustomPieChart(this.categoryWiseList, {super.key});
  final Map<String, double> categoryWiseList;
  final StatisticsController statisticsController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        (() => PieChart(
              dataMap: categoryWiseList,
              colorList: AppColors.pieChartColors,
              animationDuration: const Duration(milliseconds: 1500),
              chartRadius: MediaQuery.of(context).size.width / 1.25,
              baseChartColor: Colors.transparent,
              chartValuesOptions: ChartValuesOptions(
                chartValueStyle: TextStyle(
                  color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight,
                ),
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: true,
                showChartValueBackground: false,
                decimalPlaces: 0,
              ),
              legendOptions: LegendOptions(
                showLegends: true,
                legendShape: BoxShape.circle,
                legendPosition: LegendPosition.bottom,
                legendTextStyle: TextStyle(
                  color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight,
                ),
                showLegendsInRow: true,
              ),
            )),
      ),
    );
  }
}
