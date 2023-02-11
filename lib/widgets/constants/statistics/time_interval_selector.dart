import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/controllers/statistics_controller.dart';

class TimeIntervalSelector extends StatelessWidget {
  TimeIntervalSelector({super.key});
  final StatisticsController statisticsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [],
    );
  }
}
