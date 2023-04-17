import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_colors.dart';
import '../features/user_categories/category_list.dart';
import 'navigation_drawer.dart';
import '../controllers/theme_controller.dart';
import '../controllers/new_transaction_controller.dart';
import '../features/appbar/custom_appbar.dart';
import '../features/user_categories/category_add_popup.dart';

class UserCategories extends StatefulWidget {
  const UserCategories({super.key});

  @override
  State<UserCategories> createState() => _UserCategoriesState();
}

class _UserCategoriesState extends State<UserCategories> with TickerProviderStateMixin {
  final ThemeController themeController = Get.find();

  final NewTransactionController newTransactionController = Get.find();

  Future<void> changeState() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TabController tabBarController = TabController(length: 2, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Your Categories'),
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: [
          Obx(
            (() => DefaultTabController(
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
                )),
          ),
          Expanded(
            child: TabBarView(
              controller: tabBarController,
              children: [
                RefreshIndicator(
                    color: AppColors.appBarFillColor,
                    onRefresh: (() => changeState()),
                    child: CategoryList('Expense', changeState),),
                RefreshIndicator(
                    color: AppColors.appBarFillColor,
                    onRefresh: (() => changeState()),
                    child: CategoryList('Income', changeState),),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 45,
        width: 150,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          onPressed: (() {
            showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return CategoryPopUp(
                    0,
                    '',
                    0,
                    0,
                    changeState,
                  );
                });
          }),
          child: const Text(
            "+ Add Category",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
