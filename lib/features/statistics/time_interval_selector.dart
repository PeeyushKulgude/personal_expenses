import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/controllers/statistics_controller.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';

import '../../themes/app_colors.dart';

class TimeIntervalSelector extends StatelessWidget {
  TimeIntervalSelector({super.key});
  final StatisticsController statisticsController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => showDatePicker(
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    dialogTheme: DialogTheme(
                      backgroundColor: themeController.isDarkMode.value
                          ? AppColors.alertDialogBackgroundColorDark.withAlpha(255)
                          : AppColors.alertDialogBackgroundColorLight.withAlpha(255),
                    ),
                    colorScheme: const ColorScheme.dark(
                      primary: Color.fromARGB(255, 179, 3, 3),
                      onPrimary: Colors.white,
                      onSurface: Colors.redAccent,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark
                            : AppColors.titleTextColorLight,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
              context: context,
              initialDate: statisticsController.startDate.value,
              firstDate: DateTime(2000),
              lastDate: statisticsController.endDate.value,
            ).then(
              (value) {
                if (value != null) {
                  statisticsController.startDate.value = value;
                  statisticsController.findCategorySum();
                }
                return;
              },
            ),
            child: Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.appBarFillColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(statisticsController.startDate.value),
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.dayHeaderDateTextColorDark
                          : AppColors.dayHeaderDateTextColorLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Text(
              '-',
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.dayHeaderDateTextColorDark
                    : AppColors.dayHeaderDateTextColorLight,
              ),
            ),
          ),
          TextButton(
            onPressed: () => showDatePicker(
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    dialogTheme: DialogTheme(
                      backgroundColor: themeController.isDarkMode.value
                          ? AppColors.alertDialogBackgroundColorDark.withAlpha(255)
                          : AppColors.alertDialogBackgroundColorLight.withAlpha(255),
                    ),
                    colorScheme: const ColorScheme.dark(
                      primary: Color.fromARGB(255, 179, 3, 3),
                      onPrimary: Colors.white,
                      onSurface: Colors.redAccent,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark
                            : AppColors.titleTextColorLight,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
              context: context,
              initialDate: statisticsController.endDate.value,
              firstDate: statisticsController.startDate.value,
              lastDate: DateTime.now(),
            ).then(
              (value) {
                if (value != null) {
                  statisticsController.endDate.value = value;
                  statisticsController.findCategorySum();
                }
                return;
              },
            ),
            child: Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.appBarFillColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(statisticsController.endDate.value),
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.dayHeaderDateTextColorDark
                          : AppColors.dayHeaderDateTextColorLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
