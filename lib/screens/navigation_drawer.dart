import 'package:flutter/material.dart';
import 'package:personal_expenses/controllers/sms_controller.dart';
import 'package:personal_expenses/controllers/statistics_controller.dart';
import 'package:personal_expenses/screens/settings.dart';
import 'package:personal_expenses/screens/statistics.dart';
import 'buy_me_a_coffee_page.dart';
import 'my_home_page.dart';
import 'sms_display.dart';
import '../themes/app_colors.dart';
import '../../controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'user_categories.dart';

class CustomNavigationDrawer extends StatelessWidget {
  CustomNavigationDrawer({super.key});
  final ThemeController themeController = Get.find();
  final SmsController smsController = Get.find();
  final StatisticsController statisticsController = Get.put(StatisticsController());

  Widget buildHeader(BuildContext context) =>
      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top));

  Widget buildMenuItems1(BuildContext context) => Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
        child: Wrap(
          runSpacing: MediaQuery.of(context).size.height * 0.005,
          children: [
            ListTile(
              leading: Icon(
                Icons.home_rounded,
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
              onTap: (() => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: ((context) => const MyHomePage())))),
            ),
            ListTile(
              leading: Icon(
                Icons.pie_chart_rounded,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
              title: Text(
                'Statistics',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onTap: (() {
                statisticsController.findCategorySum();
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Scaffold(body: StatisticsDisplay()))));
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

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => const SmsDisplay())));
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

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => const UserCategories())));
              }),
            ),
            ListTile(
              leading: Icon(
                Icons.settings_rounded,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onTap: (() {
                smsController.getNotificationCategories();
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Settings())));
              }),
            ),
          ],
        ),
      );

  Widget buildMenuItems2(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height / 30,
          right: MediaQuery.of(context).size.height / 30,
          bottom: MediaQuery.of(context).size.height / 30,
        ),
        child: Wrap(
          runSpacing: MediaQuery.of(context).size.height * 0.005,
          children: [
            ListTile(
              leading: Icon(
                Icons.coffee_rounded,
                color: themeController.isDarkMode.value
                    ? AppColors.iconColor1Dark
                    : AppColors.iconColor1Light,
              ),
              title: Text(
                'Buy Me A Coffee',
                style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight),
              ),
              onTap: (() => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: ((context) => BuyMeACoffeePage())))),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems1(context),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              thickness: 1,
              color: themeController.isDarkMode.value
                  ? AppColors.cardBorderSideColorDark.withOpacity(1)
                  : AppColors.cardBorderSideColorLight,
            ),
          ),
          buildMenuItems2(context),
        ],
      ),
    );
  }
}
