import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/widgets/constants/user_categories/category_card.dart';

import '../../models/categories.dart';
import '../../themes/app_colors.dart';
import 'navigation_drawer.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/new_transaction_controller.dart';
import '../constants/appbar/custom_appbar.dart';
import '../constants/user_categories/category_add_popup.dart';

class UserCategories extends StatefulWidget {
  const UserCategories({super.key});

  @override
  State<UserCategories> createState() => _UserCategoriesState();
}

class _UserCategoriesState extends State<UserCategories> {
  final ThemeController themeController = Get.find();

  final NewTransactionController newTransactionController = Get.find();

  void changeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Your Categories'),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * 0.9,
              child: FutureBuilder(
                future: newTransactionController.readAllCategories(),
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
                          return CategoryCard(category, changeState);
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
            ),
          ],
        ),
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
