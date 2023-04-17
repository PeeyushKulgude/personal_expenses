import 'package:flutter/material.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/features/appbar/custom_appbar.dart';
import '../themes/app_colors.dart';
import '../features/settings/notification settings/notification_settings.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Settings'),
      drawer: CustomNavigationDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 30),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.notification_add_rounded,
                color: themeController.isDarkMode.value ? AppColors.iconColor1Dark : AppColors.iconColor1Light,
              ),
              title: Text(
                'Notification Settings',
                style: TextStyle(color: themeController.isDarkMode.value ? AppColors.titleTextColorDark : AppColors.titleTextColorLight),
              ),
              onTap: (() {
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => NotificationSettings())));
              }),
            ),
            Divider(
              thickness: 1,
              color: themeController.isDarkMode.value ? AppColors.cardBorderSideColorDark.withOpacity(1) : AppColors.cardBorderSideColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
