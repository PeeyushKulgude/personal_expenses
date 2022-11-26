import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/screens/pie_chart.dart';
import 'my_home_page.dart';
import 'sms_display.dart';
import '../../themes/app_themes.dart';
import '../../themes/app_colors.dart';
import '../../../controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'user_categories/user_categories.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({super.key});
  final ThemeController themeController = Get.find();

  Widget buildHeader(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top));

  Widget buildMenuItems(BuildContext context) => Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
        child: Wrap(
          runSpacing: MediaQuery.of(context).size.height / 50,
          children: [
            ListTile(
              leading: Icon(
                Icons.home_filled,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onTap: (() => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => MyHomePage())))),
            ),
            ListTile(
              leading: Icon(
                Icons.pie_chart_sharp,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
              title: Text(
                'Pie Chart',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onTap: (() {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => PieChartDisplay())));
              }),
            ),
            ListTile(
              leading: Icon(
                Icons.message_rounded,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
              title: Text(
                'Add Via SMS',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onTap: (() {
                Navigator.pop(context);

                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => SmsDisplay())));
              }),
            ),
            ListTile(
              leading: Icon(
                Icons.category_rounded,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
              title: Text(
                'Your Categories',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onTap: (() {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => UserCategories())));
              }),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themeController.isDarkMode.value
          ? AppColors.alertDialogBackgroundColorDark
          : AppColors.alertDialogBackgroundColorLight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }
}
