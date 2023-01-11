import 'package:flutter/material.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/widgets/constants/appbar/custom_appbar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';
import '../../controllers/home_page_controller.dart';
import '../../themes/app_colors.dart';
import '../constants/animations/no_statistics_animation.dart';

class PieChartDisplay extends StatelessWidget {
  PieChartDisplay({super.key});

  final HomePageController homePageController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    homePageController.findCategorySum();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Statistics'),
      drawer: NavigationDrawer(),
      body: Center(
        child: homePageController.categoryWiseList.isEmpty? NoStatisticsAnimation() : PieChart(
              dataMap: homePageController.categoryWiseList,
              animationDuration: const Duration(milliseconds: 1500),
              chartRadius: MediaQuery.of(context).size.width / 1.25,
              baseChartColor: Colors.transparent,
              chartValuesOptions: ChartValuesOptions(
                  chartValueStyle: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.titleTextColorDark
                          : AppColors.titleTextColorLight),
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  showChartValueBackground: false),
              legendOptions: LegendOptions(
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendPosition: LegendPosition.bottom,
                  legendTextStyle: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight,
                  ),
                  showLegendsInRow: true),
            ),
      ),
    );
  }
}
