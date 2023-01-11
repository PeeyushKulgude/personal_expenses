import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/database/icons_database.dart';

import '../../../themes/app_colors.dart';
import '../../../controllers/theme_controller.dart';
import '../../../controllers/new_transaction_controller.dart';

class IconPopUp extends StatelessWidget {
  IconPopUp({super.key});

  final ThemeController themeController = Get.find();
  final NewTransactionController newTransactionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      height: MediaQuery.of(context).size.height * 0.6,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'General',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.298,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    22,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 1;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 1]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Entertainment',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.175,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    11,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 23;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 23]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Food',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.237,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    17,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 34;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 34]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Apparel',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.174,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    13,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 51;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 51]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Education',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.174,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    12,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 64;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 64]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Electronics',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.114,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    10,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 76;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 76]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'People',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.174,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    11,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 86;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 86]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Festival',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.114,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    6,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 97;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 97]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Sport',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.174,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    13,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 103;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 103]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Transport',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.114,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    8,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 116;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 116]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Health',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.114,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    6,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 124;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 124]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Finance',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.114,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    6,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 130;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 130]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                'Miscellaneous',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  children: List.generate(
                    3,
                    (index) => IconButton(
                      onPressed: (() {
                        newTransactionController.currCategoryIconCode.value =
                            index + 136;
                        Navigator.of(context).pop();
                      }),
                      icon: SvgPicture.asset(
                        CategoryIcons.iconData[index + 136]!,
                        color: themeController.isDarkMode.value
                            ? AppColors.newTransactionIconColorDark
                            : AppColors.newTransactionIconColorLight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
