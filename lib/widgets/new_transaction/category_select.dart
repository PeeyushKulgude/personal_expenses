import 'package:flutter/material.dart';
import '../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';

class CategorySelect extends StatelessWidget {
  CategorySelect({super.key});

  final NewTransactionController c = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          DropdownButton(
            hint: c.currCategory.value == ""
                ? Text(
                    'Select Category',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.subtitleTextColorDark
                          : AppColors.subtitleTextColorLight,
                    ),
                  )
                : Text(
                    c.currCategory.value,
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.titleTextColorDark
                          : AppColors.titleTextColorLight,
                    ),
                  ),
            dropdownColor: themeController.isDarkMode.value
                ? AppColors.cardBackgroundColorDark
                : AppColors.cardBackgroundColorLight,
            iconEnabledColor: themeController.isDarkMode.value
                ? AppColors.newTransactionIconColorDark
                : AppColors.newTransactionIconColorLight,
            elevation: 16,
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
            underline: Container(
              height: 1,
              color: themeController.isDarkMode.value
                  ? AppColors.newTransactionTextFieldColorDark
                  : AppColors.newTransactionTextFieldColorLight,
            ),
            onChanged: ((value) => c.currCategory.value = value as String),
            items: List.generate(
              c.userCategories.length,
              (index) {
                return DropdownMenuItem(
                  value: c.userCategories[index].title,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            c.userCategories[index].title,
                            style: TextStyle(
                              color: themeController.isDarkMode.value
                                  ? AppColors.titleTextColorDark
                                  : AppColors.titleTextColorLight,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            c.startEditCategory(
                                context,
                                c.userCategories[index].title,
                                c.userCategories[index].id as int);
                          },
                          color: themeController.isDarkMode.value
                              ? AppColors.newTransactionIconColorDark
                              : AppColors.newTransactionIconColorLight,
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            if (c.userCategories.length == 1) {
                              c.deleteCategory(
                                  c.userCategories[index].id as int);
                              Navigator.of(context).pop();
                              c.userCategories.value = [];
                            } else {
                              c.deleteCategory(
                                  c.userCategories[index].id as int);
                              Navigator.of(context).pop();
                            }
                          },
                          color: AppColors.deleteIconColor,
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () => c.startAddCategory(context),
            icon: const Icon(Icons.add),
            color: themeController.isDarkMode.value
                ? AppColors.newTransactionTextFieldColorDark
                : AppColors.newTransactionTextFieldColorLight,
          ),
        ],
      ),
    );
  }
}
