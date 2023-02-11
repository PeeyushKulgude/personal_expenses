import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/database/icons_database.dart';

import '../../../../controllers/new_transaction_controller.dart';
import '../../../../controllers/theme_controller.dart';
import '../../../../models/category.dart';
import '../../../../themes/app_colors.dart';

class CategoryGridView extends StatelessWidget {
  final String categoryType;
  CategoryGridView(this.categoryType, {super.key});

  final NewTransactionController newTransactionController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.491,
      child: FutureBuilder(
        future: newTransactionController.getSpecificCategories(categoryType),
        builder: (context, AsyncSnapshot<List<Category>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
                size: 25,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  final category = snapshot.data![index];
                  return Column(
                    children: [
                      IconButton(
                        onPressed: (() {
                          newTransactionController.currCategoryTitle.value =
                              category.title;
                          newTransactionController.currCategoryIconCode.value =
                              category.iconCode;
                          newTransactionController.currCategoryType.value =
                              category.categoryType;
                          Navigator.of(context).pop();
                        }),
                        icon: SvgPicture.asset(
                          CategoryIcons.iconData[category.iconCode]!,
                          color: themeController.isDarkMode.value
                              ? AppColors.newTransactionIconColorDark
                              : AppColors.newTransactionIconColorLight,
                        ),
                      ),
                      SizedBox(
                        height: 14,
                        child: FittedBox(
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
                      ),
                    ],
                  );
                }),
              );
            }
          }
          return Center(
            child: Text(
              "You haven't added any categories yet. Go to menu to add category.",
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }
}
