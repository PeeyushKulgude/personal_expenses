import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expenses/models/category.dart';
import 'package:get/get.dart';

import '../../../controllers/new_transaction_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../database/icons_database.dart';
import '../../../themes/app_colors.dart';
import 'category_add_popup.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function changeState;
  CategoryCard(this.category, this.changeState, {super.key});

  final ThemeController themeController = Get.find();
  final NewTransactionController newTransactionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((() => Card(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
                color: themeController.isDarkMode.value
                    ? AppColors.cardBorderSideColorDark
                    : AppColors.cardBorderSideColorLight,
                width: 1),
          ),
          elevation: 2,
          color: themeController.isDarkMode.value
              ? AppColors.cardBackgroundColorDark
              : AppColors.cardBackgroundColorLight,
          child: ListTile(
            leading: SvgPicture.asset(
              height: MediaQuery.of(context).size.height * 0.05,
              CategoryIcons.iconData[category.iconCode]!,
              color: themeController.isDarkMode.value
                  ? AppColors.newTransactionIconColorDark
                  : AppColors.newTransactionIconColorLight,
            ),
            title: Text(
              category.title,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              category.categoryType,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.subtitleTextColorDark
                    : AppColors.subtitleTextColorLight,
                fontSize: 11,
              ),
            ),
            trailing: SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
              child: Row(
                children: [
                  IconButton(
                    onPressed: (() {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return CategoryPopUp(
                              category.id!,
                              category.title,
                              category.categoryType == 'Income' ? 1 : 2,
                              category.iconCode,
                            );
                          });
                      newTransactionController.readAllCategories();
                    }),
                    color: themeController.isDarkMode.value
                        ? AppColors.iconColor1Dark
                        : AppColors.iconColor1Light,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      if (newTransactionController.userCategories.length == 1) {
                        newTransactionController
                            .deleteCategory(category.id as int);
                        newTransactionController.userCategories.value = [];
                      } else {
                        newTransactionController
                            .deleteCategory(category.id as int);
                      }
                      changeState();
                    },
                    color: AppColors.deleteIconColor,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
