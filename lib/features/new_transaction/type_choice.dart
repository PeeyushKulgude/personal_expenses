import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';
import 'category_select/category_gridview.dart';

class TypeChoice extends StatefulWidget {
  const TypeChoice({super.key});

  @override
  State<TypeChoice> createState() => _TypeChoiceState();
}

class _TypeChoiceState extends State<TypeChoice> with TickerProviderStateMixin {
  final NewTransactionController c = Get.find();

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        if (c.typeChoice.value == 0) {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              TabController tabBarController = TabController(length: 2, vsync: this);
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
                        unselectedLabelColor: themeController.isDarkMode.value
                            ? AppColors.subtitleTextColorDark
                            : AppColors.subtitleTextColorLight,
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
                      height: MediaQuery.of(context).size.height * 0.425,
                      child: TabBarView(
                        controller: tabBarController,
                        children: [
                          CategoryGridView('Expense'),
                          CategoryGridView('Income'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
      child: Obx(
        () {
          if (c.typeChoice.value == 1) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.045,
              decoration: BoxDecoration(
                color: AppColors.incomeBackgroundColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.incomeBorderColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Income',
                  style: TextStyle(
                    color: AppColors.incomePrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }
          if (c.typeChoice.value == 2) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.045,
              decoration: BoxDecoration(
                color: AppColors.expenseBackgroundColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.expenseBorderColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Expense',
                  style: TextStyle(
                    color: AppColors.expensePrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.045,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: themeController.isDarkMode.value
                      ? AppColors.cardBorderSideColorDark
                      : AppColors.cardBorderSideColorLight,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  'Income / Expense',
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark.withOpacity(0.7)
                        : AppColors.titleTextColorLight.withOpacity(0.7),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
