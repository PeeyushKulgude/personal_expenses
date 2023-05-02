import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../database/icons_database.dart';
import 'category_gridview.dart';
import '../../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> with TickerProviderStateMixin {
  final NewTransactionController newTransactionController = Get.find();

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            TabController tabBarController = TabController(
              length: 2,
              initialIndex: newTransactionController.typeChoice.value == 1 ? 1 : 0,
              vsync: this,
            );
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
      }),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.325,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: themeController.isDarkMode.value
              ? AppColors.canvasColorDark
              : AppColors.canvasColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          (() => newTransactionController.currCategoryTitle.value == ""
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/category.svg',
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Category',
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark.withOpacity(0.7)
                            : AppColors.titleTextColorLight.withOpacity(0.7),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CategoryIcons.iconData[newTransactionController.currCategoryIconCode.value]!,
                      color: themeController.isDarkMode.value
                          ? AppColors.newTransactionIconColorDark
                          : AppColors.newTransactionIconColorLight,
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        newTransactionController.currCategoryTitle.value,
                        style: TextStyle(
                          color: themeController.isDarkMode.value
                              ? AppColors.titleTextColorDark
                              : AppColors.titleTextColorLight,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )),
        ),
      ),
    );
  }
}
