import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/controllers/statistics_controller.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/widgets/appbar/custom_appbar.dart';
import '../themes/app_colors.dart';
import '../widgets/animations/no_statistics_animation.dart';
import '../widgets/statistics/custom_pie_chart.dart';
import '../widgets/statistics/category_graphs_and_details.dart';
import '../widgets/statistics/time_interval_selector.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';

class StatisticsDisplay extends StatefulWidget {
  const StatisticsDisplay({super.key});

  @override
  State<StatisticsDisplay> createState() => _StatisticsDisplayState();
}

class _StatisticsDisplayState extends State<StatisticsDisplay> {
  final ThemeController themeController = Get.find();

  Future<void> refresh() async {
    setState(() {});
  }

  void showDetailsOfEachCategory(BuildContext context) {
    showBottomSheet(
      elevation: 0,
      context: context,
      builder: ((context) => Obx(
            () => Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - Get.statusBarHeight,
              color: themeController.isDarkMode.value
                  ? AppColors.canvasColorDark
                  : AppColors.canvasColorLight,
              child: const CategoryGraphAndDetails(),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Statistics'),
      drawer: CustomNavigationDrawer(),
      body: RefreshIndicator(
        color: AppColors.appBarFillColor,
        onRefresh: (() => refresh()),
        child: Stack(
          children: [
            ListView(),
            GetBuilder<StatisticsController>(
              builder: (statisticsController) {
                if (statisticsController.pageState.value == AppState.initial) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: themeController.isDarkMode.value
                          ? AppColors.iconColor1Dark
                          : AppColors.iconColor1Light,
                      size: 50,
                    ),
                  );
                } else if (statisticsController.pageState.value == AppState.loading) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: themeController.isDarkMode.value
                          ? AppColors.iconColor1Dark
                          : AppColors.iconColor1Light,
                      size: 50,
                    ),
                  );
                } else if (statisticsController.pageState.value == AppState.loaded) {
                  return GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        showDetailsOfEachCategory(context);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).padding.bottom + 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TimeIntervalSelector(),
                          CustomPieChart(statisticsController.categoryWiseList),
                          Obx(
                            () => Column(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: themeController.isDarkMode.value
                                      ? AppColors.iconColor1Dark
                                      : AppColors.iconColor1Light,
                                ),
                                Text(
                                  'Swipe up to see details of each category',
                                  style: TextStyle(
                                    color: themeController.isDarkMode.value
                                        ? AppColors.titleTextColorDark
                                        : AppColors.titleTextColorLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (statisticsController.pageState.value == AppState.error) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom + 10),
                    child: Column(
                      children: [
                        TimeIntervalSelector(),
                        Center(child: NoStatisticsAnimation()),
                      ],
                    ),
                  );
                } else if (statisticsController.pageState.value == AppState.empty) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom + 10),
                    child: Column(
                      children: [
                        TimeIntervalSelector(),
                        Center(child: NoStatisticsAnimation()),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom + 10),
                    child: Column(
                      children: [
                        TimeIntervalSelector(),
                        Center(child: NoStatisticsAnimation()),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
