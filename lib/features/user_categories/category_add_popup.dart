import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/icons_database.dart';

import '../../models/category.dart';
import '../../themes/app_colors.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/new_transaction_controller.dart';
import 'icon_choice_popup.dart';

class CategoryPopUp extends StatelessWidget {
  final categoryController = TextEditingController();
  final int editing;
  final Function changeState;

  CategoryPopUp(this.editing, title, int type, int iconCode, this.changeState, {super.key}) {
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
          : Colors.white,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  (() => InkWell(
                        onTap: (() => newTransactionController.typeChoice.value = 1),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: newTransactionController.typeChoice.value == 1
                                  ? AppColors.incomeBorderColor
                                  : Colors.transparent,
                              width: 1,
                            ),
                            color: newTransactionController.typeChoice.value == 1
                                ? AppColors.incomeBackgroundColor
                                : themeController.isDarkMode.value
                                    ? AppColors.canvasColorDark
                                    : AppColors.fieldColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_downward_rounded,
                                  color: newTransactionController.typeChoice.value == 1
                                      ? AppColors.incomePrimaryColor
                                      : themeController.isDarkMode.value
                                          ? AppColors.iconColor1Dark
                                          : AppColors.iconColor1Light,
                                ),
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    color: newTransactionController.typeChoice.value == 1
                                        ? AppColors.incomePrimaryColor
                                        : themeController.isDarkMode.value
                                            ? AppColors.subtitleTextColorDark
                                            : AppColors.subtitleTextColorLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
                Obx(
                  (() => InkWell(
                        onTap: (() => newTransactionController.typeChoice.value = 2),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: newTransactionController.typeChoice.value == 2
                                  ? AppColors.expenseBorderColor
                                  : Colors.transparent,
                              width: 1,
                            ),
                            color: newTransactionController.typeChoice.value == 2
                                ? AppColors.expenseBackgroundColor
                                : themeController.isDarkMode.value
                                    ? AppColors.canvasColorDark
                                    : AppColors.fieldColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_upward_rounded,
                                  color: newTransactionController.typeChoice.value == 2
                                      ? AppColors.expensePrimaryColor
                                      : themeController.isDarkMode.value
                                          ? AppColors.iconColor1Dark
                                          : AppColors.iconColor1Light,
                                ),
                                Text(
                                  'Expense',
                                  style: TextStyle(
                                    color: newTransactionController.typeChoice.value == 2
                                        ? AppColors.expensePrimaryColor
                                        : themeController.isDarkMode.value
                                            ? AppColors.subtitleTextColorDark
                                            : AppColors.subtitleTextColorLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ],
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
              changeState();
            }
          },
        ),
      ],
    );
  }
}
