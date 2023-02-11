import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/home_page_controller.dart';
import '../../../controllers/statistics_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../database/icons_database.dart';
import '../../../themes/app_colors.dart';

class CategoryTab extends StatelessWidget {
  CategoryTab(this.title, this.iconCode, {super.key});
  final String title;
  final int iconCode;
  final ThemeController themeController = Get.find();
  final HomePageController homePageController = Get.find();
  final StatisticsController statisticsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx((() => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                CategoryIcons.iconData[iconCode]!,
                color: themeController.isDarkMode.value ? AppColors.newTransactionIconColorDark : AppColors.newTransactionIconColorLight,
                height: 30,
              ),
            ),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight,
                ),
              ),
            )
          ],
        )));
  }
}
