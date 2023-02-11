import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/controllers/home_page_controller.dart';
import 'package:personal_expenses/widgets/constants/statistics/category_tab.dart';

import '../../../controllers/statistics_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';
import '../animations/no_transaction_animation.dart';
import 'transaction_card_without_buttons.dart';

class CategoryGraphAndDetails extends StatefulWidget {
  const CategoryGraphAndDetails({super.key});

  @override
  State<CategoryGraphAndDetails> createState() => _CategoryGraphAndDetailsState();
}

class _CategoryGraphAndDetailsState extends State<CategoryGraphAndDetails> with TickerProviderStateMixin {
  final ThemeController themeController = Get.find();
  final HomePageController homePageController = Get.find();
  final StatisticsController statisticsController = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    var categoryTabs = List.generate(
      statisticsController.categoryList.length,
      (index) => CategoryTab(statisticsController.categoryList[index].title, statisticsController.categoryList[index].iconCode),
    );

    TabController tabBarController = TabController(initialIndex: (statisticsController.categoryList.length / 2).floor(), length: statisticsController.categoryList.length, vsync: this);

    return Column(
      children: [
        Obx(
          (() => DefaultTabController(
                length: statisticsController.categoryList.length,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: AppColors.appBarFillColor,
                  controller: tabBarController,
                  tabs: categoryTabs,
                ),
              )),
        ),
        Expanded(
          child: TabBarView(
            controller: tabBarController,
            children: List.generate(
              statisticsController.categoryList.length,
              (index) => FutureBuilder(
                future: homePageController.getCategoryAndDatewiseTransactions(statisticsController.categoryList[index].title),
                builder: (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: themeController.isDarkMode.value ? AppColors.iconColor1Dark : AppColors.iconColor1Light,
                        size: 50,
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TransactionCardWithoutButtons(snapshot.data![index]),
                        ),
                      );
                    } else {
                      return NoTransactionFoundAnimation();
                    }
                  }
                  return NoTransactionFoundAnimation();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
