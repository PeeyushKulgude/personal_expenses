import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';
import '../controllers/home_page_controller.dart';

class PieChartDisplay extends StatelessWidget {
  PieChartDisplay({super.key});

  final HomePageController homePageController = Get.find();
  @override
  Widget build(BuildContext context) {
    homePageController.findCategorySum();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      appBar: AppBar(
        title: const Text(
          'Pie Chart',
        ),
        backgroundColor: const Color.fromARGB(255, 179, 3, 3),
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: PieChart(
          dataMap: homePageController.categoryWiseList,
          animationDuration: const Duration(milliseconds: 1500),
          chartRadius: MediaQuery.of(context).size.width / 1.25,
          baseChartColor: Colors.transparent,
          chartValuesOptions: const ChartValuesOptions(
              chartValueStyle: TextStyle(color: Colors.white),
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              showChartValueBackground: false),
          legendOptions: const LegendOptions(
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(color: Colors.white),
              legendPosition: LegendPosition.bottom,
              showLegendsInRow: true),
        ),
      ),
    );
  }
}
