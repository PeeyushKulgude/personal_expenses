import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../database/icons_database.dart';
import '../../../models/categories.dart';
import '../../../themes/app_colors.dart';
import '../navigation_drawer.dart';
import '../../../controllers/theme_controller.dart';
import '../../../controllers/new_transaction_controller.dart';
import 'category_add_popup.dart';

class UserCategories extends StatefulWidget {
  UserCategories({super.key});

  @override
  State<UserCategories> createState() => _UserCategoriesState();
}

class _UserCategoriesState extends State<UserCategories> {
  ThemeController themeController = Get.find();

  NewTransactionController newTransactionController = Get.find();

  changeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: TextStyle(
            color: themeController.isDarkMode.value
                ? AppColors.titleTextColorDark
                : AppColors.titleTextColorLight,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (() {
              themeController.isDarkMode.value =
                  !themeController.isDarkMode.value;
              themeController.changeTheme();
            }),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
              child: themeController.isDarkMode.value
                  ? Icon(
                      Icons.sunny,
                      key: const ValueKey('icon1'),
                      color: AppColors.appBarIconColorDark,
                    )
                  : Icon(
                      CupertinoIcons.moon_stars_fill,
                      key: const ValueKey('icon2'),
                      color: AppColors.appBarIconColorLight,
                    ),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Your Categories:",
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
                fontSize: 18,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.85,
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
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              side: BorderSide(
                                  color: themeController.isDarkMode.value
                                      ? AppColors.cardBorderSideColorDark
                                      : AppColors.cardBorderSideColorLight,
                                  width: 1),
                            ),
                            elevation: 5,
                            color: themeController.isDarkMode.value
                                ? AppColors.cardBackgroundColorDark
                                : AppColors.cardBackgroundColorLight,
                            child: ListTile(
                              leading: SvgPicture.asset(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                CategoryIcons.iconData[category.iconCode]!,
                                color: themeController.isDarkMode.value
                                    ? AppColors.newTransactionIconColorDark
                                    : AppColors.newTransactionIconColorLight,
                              ),
                              title: Text(
                                category.title,
                                style: TextStyle(
                                  color: themeController.isDarkMode.value
                                      ? AppColors.titleTextColorDark
                                      : AppColors.titleTextColorLight,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                category.categoryType,
                                style: TextStyle(
                                  color: themeController.isDarkMode.value
                                      ? AppColors.subtitleTextColorDark
                                      : AppColors.subtitleTextColorLight,
                                  fontSize: 11,
                                ),
                              ),
                              trailing: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.27,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: (() {
                                        showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return CategoryPopUp(
                                                  category.id!,
                                                  category.title,
                                                  category.categoryType ==
                                                          'Income'
                                                      ? 1
                                                      : 2,
                                                  category.iconCode,
                                                  changeState);
                                            });
                                      }),
                                      color: themeController.isDarkMode.value
                                          ? AppColors.iconColor1Dark
                                          : AppColors.iconColor1Light,
                                      icon: const Icon(Icons.edit_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        newTransactionController
                                            .deleteCategory(category.id!);
                                        changeState();
                                      },
                                      color: AppColors.deleteIconColor,
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                  return CategoryPopUp(0, '', 0, 0, changeState);
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
