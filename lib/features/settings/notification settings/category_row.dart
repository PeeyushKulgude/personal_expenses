import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/models/category.dart';
import 'package:personal_expenses/features/settings/notification%20settings/category_gridview.dart';

import '../../../controllers/theme_controller.dart';
import '../../../database/icons_database.dart';
import '../../../themes/app_colors.dart';

class NotificationCategoryRow extends StatelessWidget {
  final Category category;
  final ThemeController themeController = Get.find();
  NotificationCategoryRow(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: 30,
            child: SvgPicture.asset(
              CategoryIcons.iconData[category.iconCode]!,
              color: themeController.isDarkMode.value
                  ? AppColors.newTransactionIconColorDark
                  : AppColors.newTransactionIconColorLight,
            ),
          ),
          FittedBox(
            child: Text(
              category.title,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.subtitleTextColorDark
                    : AppColors.subtitleTextColorLight,
                fontSize: 13,
              ),
            ),
          ),
          FittedBox(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((context) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${category.categoryType} Categories',
                              style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? AppColors.titleTextColorDark
                                    : AppColors.titleTextColorLight,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SpecificCategoryGridView(category),
                        ],
                      )),
                );
              },
              child: Icon(
                Icons.edit_outlined,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
