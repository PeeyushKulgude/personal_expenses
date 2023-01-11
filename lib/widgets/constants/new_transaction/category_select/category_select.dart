import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../database/icons_database.dart';
import 'income_categories.dart';
import 'expense_categories.dart';
import '../../../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';
import '../../../../controllers/theme_controller.dart';
import '../../../../themes/app_colors.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect>
    with TickerProviderStateMixin {
  final NewTransactionController newTransactionController = Get.find();

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Selected Category:',
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
            ),
            Obx(
              (() => TextButton(
                    onPressed: (() {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          TabController tabBarController =
                              TabController(length: 2, vsync: this);
                          return Container(
                            color: themeController.isDarkMode.value
                                ? AppColors.alertDialogBackgroundColorDark
                                : AppColors.alertDialogBackgroundColorLight,
                            padding: const EdgeInsets.all(18),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Choose Category',
                                    style: TextStyle(
                                      color: themeController.isDarkMode.value
                                          ? AppColors.titleTextColorDark
                                          : AppColors.titleTextColorLight,
                                    ),
                                  ),
                                ),
                                DefaultTabController(
                                  length: 2,
                                  child: TabBar(
                                    indicatorColor: AppColors.appBarFillColor,
                                    controller: tabBarController,
                                    labelColor: themeController.isDarkMode.value
                                        ? AppColors.titleTextColorDark
                                        : AppColors.titleTextColorLight,
                                    tabs: const [
                                      Tab(
                                        text: 'Expense',
                                      ),
                                      Tab(
                                        text: 'Income',
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.425,
                                  child: TabBarView(
                                    controller: tabBarController,
                                    children: [
                                      ExpenseCategories(),
                                      IncomeCategories(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
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
                    child: newTransactionController.currCategoryTitle.value ==
                            ""
                        ? Text(
                            'Select Category',
                            style: TextStyle(
                              color: themeController.isDarkMode.value
                                  ? AppColors.titleTextColorDark
                                  : AppColors.titleTextColorLight,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                CategoryIcons.iconData[newTransactionController
                                    .currCategoryIconCode.value]!,
                                color: themeController.isDarkMode.value
                                    ? AppColors.newTransactionIconColorDark
                                    : AppColors.newTransactionIconColorLight,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                newTransactionController
                                    .currCategoryTitle.value,
                                style: TextStyle(
                                  color: themeController.isDarkMode.value
                                      ? AppColors.titleTextColorDark
                                      : AppColors.titleTextColorLight,
                                ),
                              ),
                            ],
                          ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
