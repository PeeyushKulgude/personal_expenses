import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/controllers/statistics_controller.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/widgets/constants/appbar/custom_appbar.dart';
import '../themes/app_colors.dart';
import '../widgets/constants/statistics/custom_pie_chart.dart';
import '../widgets/constants/statistics/category_graphs_and_details.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';
import '../widgets/constants/animations/no_statistics_animation.dart';

class StatisticsDisplay extends StatefulWidget {
  const StatisticsDisplay({super.key});

  @override
  State<StatisticsDisplay> createState() => _StatisticsDisplayState();
}

class _StatisticsDisplayState extends State<StatisticsDisplay> {
  final StatisticsController statisticsController = Get.put(StatisticsController());

  final ThemeController themeController = Get.find();

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Statistics'),
      drawer: NavigationDrawer(),
      body: RefreshIndicator(
        color: AppColors.appBarFillColor,
        onRefresh: (() => refresh()),
        child: Stack(
          children: [
            ListView(),
            FutureBuilder(
              future: statisticsController.findCategorySum(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: themeController.isDarkMode.value
                          ? AppColors.iconColor1Dark
                          : AppColors.iconColor1Light,
                      size: 50,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity! < 0) {
                          showBottomSheet(
                            context: context,
                            builder: ((context) => Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: themeController.isDarkMode.value
                                      ? AppColors.canvasColorDark
                                      : AppColors.canvasColorLight,
                                  child: const CategoryGraphAndDetails(),
                                )),
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomPieChart(snapshot.data!),
                          Column(
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
                        ],
                      ),
                    );
                  } else {
                    return Center(child: NoStatisticsAnimation());
                  }
                }
                return Center(child: NoStatisticsAnimation());
              }),
            ),
          ],
        ),
      ),
    );
  }
}
