import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/icons_database.dart';

import '../../../models/category.dart';
import '../../../themes/app_colors.dart';
import '../../../controllers/theme_controller.dart';
import '../../../controllers/new_transaction_controller.dart';
import 'icon_choice_popup.dart';

class CategoryPopUp extends StatelessWidget {
  final categoryController = TextEditingController();
  final int editing;

  CategoryPopUp(this.editing, title, int type, int iconCode, {super.key}) {
    categoryController.text = title;
    newTransactionController.typeChoice.value = type;
    newTransactionController.currCategoryIconCode.value = iconCode;
  }

  final ThemeController themeController = Get.find();
  final NewTransactionController newTransactionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
            color: themeController.isDarkMode.value
                ? AppColors.cardBorderSideColorDark
                : AppColors.cardBorderSideColorLight,
            width: 1),
      ),
      elevation: 10,
      backgroundColor: themeController.isDarkMode.value
          ? AppColors.alertDialogBackgroundColorDark
          : AppColors.alertDialogBackgroundColorLight,
      title: Text(editing == 0 ? 'Add A New Category' : 'Edit Category',
          style: TextStyle(
            color: themeController.isDarkMode.value
                ? AppColors.titleTextColorDark
                : AppColors.titleTextColorLight,
          )),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              controller: categoryController,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appBarFillColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appBarFillColor,
                  ),
                ),
                labelText: 'Category Name',
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.titleTextColorDark
                      : AppColors.titleTextColorLight,
                ),
              ),
            ),
            Obx(
              (() => Container(
                    margin: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                width: 1,
                                color: themeController.isDarkMode.value
                                    ? AppColors.titleTextColorDark
                                    : AppColors.titleTextColorLight),
                          ),
                        ),
                      ),
                      onPressed: (() {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  side: BorderSide(
                                      color: themeController.isDarkMode.value
                                          ? AppColors.cardBorderSideColorDark
                                          : AppColors.cardBorderSideColorLight,
                                      width: 1),
                                ),
                                elevation: 10,
                                backgroundColor: themeController.isDarkMode.value
                                    ? AppColors.alertDialogBackgroundColorDark
                                    : AppColors.alertDialogBackgroundColorLight,
                                content: IconPopUp(),
                              );
                            }));
                      }),
                      child: newTransactionController.currCategoryIconCode.value == 0
                          ? Text(
                              "Choose Icon",
                              style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? AppColors.titleTextColorDark
                                    : AppColors.titleTextColorLight,
                              ),
                            )
                          : SvgPicture.asset(
                              height: MediaQuery.of(context).size.height * 0.03,
                              CategoryIcons
                                  .iconData[newTransactionController.currCategoryIconCode.value]!,
                              color: themeController.isDarkMode.value
                                  ? AppColors.newTransactionIconColorDark
                                  : AppColors.newTransactionIconColorLight,
                            ),
                    ),
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Income',
                            style: TextStyle(
                              color: themeController.isDarkMode.value
                                  ? AppColors.titleTextColorDark
                                  : AppColors.titleTextColorLight,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Expense',
                            style: TextStyle(
                              color: themeController.isDarkMode.value
                                  ? AppColors.titleTextColorDark
                                  : AppColors.titleTextColorLight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          (() => IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/down-arrow.svg',
                                  color: newTransactionController.typeChoice.value == 1
                                      ? AppColors.incomePrimaryColor
                                      : themeController.isDarkMode.value
                                          ? AppColors.newTransactionIconColorDark
                                          : AppColors.newTransactionIconColorLight,
                                ),
                                onPressed: (() => newTransactionController.typeChoice.value = 1),
                                color: Colors.black,
                                splashRadius: 1,
                              )),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          (() => IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/up-arrow.svg',
                                  color: newTransactionController.typeChoice.value == 2
                                      ? AppColors.expensePrimaryColor
                                      : themeController.isDarkMode.value
                                          ? AppColors.newTransactionIconColorDark
                                          : AppColors.newTransactionIconColorLight,
                                ),
                                onPressed: (() => newTransactionController.typeChoice.value = 2),
                                color: Colors.black,
                                splashRadius: 1,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            editing == 0 ? 'Add' : 'Submit',
            style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight),
          ),
          onPressed: () {
            if (categoryController.text != '' &&
                newTransactionController.typeChoice.value != 0 &&
                newTransactionController.currCategoryIconCode.value != 0) {
              if (editing == 0) {
                newTransactionController.addCategory(Category(
                    title: categoryController.text,
                    iconCode: newTransactionController.currCategoryIconCode.value,
                    categoryType:
                        newTransactionController.typeChoice.value == 1 ? 'Income' : 'Expense'));
              } else {
                newTransactionController.editCategory(Category(
                    id: editing,
                    title: categoryController.text,
                    iconCode: newTransactionController.currCategoryIconCode.value,
                    categoryType:
                        newTransactionController.typeChoice.value == 1 ? 'Income' : 'Expense'));
              }
              newTransactionController.currCategoryIconCode.value = 0;
              newTransactionController.typeChoice.value = 0;
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
