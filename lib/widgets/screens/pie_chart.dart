import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:pie_chart/pie_chart.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';
import '../../controllers/home_page_controller.dart';
import '../../themes/app_colors.dart';

class PieChartDisplay extends StatelessWidget {
  PieChartDisplay({super.key});

  final HomePageController homePageController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    homePageController.findCategorySum();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: TextStyle(
            color: themeController.isDarkMode.value
                ? AppColors.titleTextColorDark
                : AppColors.titleTextColorLight,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (() {
              themeController.isDarkMode.value =
                  !themeController.isDarkMode.value;
              themeController.changeTheme();
            }),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
              child: themeController.isDarkMode.value
                  ? Icon(
                      Icons.sunny,
                      key: const ValueKey('icon1'),
                      color: AppColors.appBarIconColorDark,
                    )
                  : Icon(
                      CupertinoIcons.moon_stars_fill,
                      key: const ValueKey('icon2'),
                      color: AppColors.appBarIconColorLight,
                    ),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 24,
            ),
            Text(
              'Expenses',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            PieChart(
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
          ],
        ),
      ),
    );
  }
}
