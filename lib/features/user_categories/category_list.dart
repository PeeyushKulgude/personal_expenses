import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../models/category.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/features/user_categories/category_card.dart';
import '../../themes/app_colors.dart';

class CategoryList extends StatelessWidget {
  final String categoryType;
  final ThemeController themeController = Get.find();
  final NewTransactionController newTransactionController = Get.find();
  final Function changeState;

  CategoryList(this.categoryType, this.changeState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 6,
      ),
      child: FutureBuilder(
        future: newTransactionController.getSpecificCategories(categoryType),
        builder: (context, AsyncSnapshot<List<Category>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
                size: 50,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  final category = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3.0,
                    ),
                    child: CategoryCard(category, changeState),
                  );
                }),
              );
            }
          }
          return Center(
            child: Text(
              "You haven't added any categories yet.",
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
