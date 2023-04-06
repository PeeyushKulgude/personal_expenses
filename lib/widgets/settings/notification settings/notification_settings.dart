import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import 'package:personal_expenses/widgets/settings/notification%20settings/display_categories.dart';
import '../../../controllers/theme_controller.dart';
import '../../../database/simple_preferences.dart';

import '../../../screens/navigation_drawer.dart';
import '../../appbar/custom_appbar.dart';

class NotificationSettings extends StatelessWidget {
  NotificationSettings({super.key});
  final appData = GetStorage();

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    appData.writeIfNull(showNewTransactionNotification, true);
    appData.writeIfNull(showReminderNotification, true);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Notification Settings'),
      drawer: CustomNavigationDrawer(),
      body: Obx((() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: ListTile(
                  title: Text(
                    'New Transaction Detected Notification',
                    style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark
                            : AppColors.titleTextColorLight),
                  ),
                  trailing: Switch(
                    activeColor: AppColors.appBarFillColor,
                    inactiveThumbColor: themeController.isDarkMode.value == true
                        ? AppColors.chartBarBackgroundColorDark
                        : AppColors.chartBarBackgroundColorLight,
                    inactiveTrackColor: themeController.isDarkMode.value == true
                        ? AppColors.chartBarBackgroundColorDark
                        : AppColors.chartBarBackgroundColorLight,
                    value: appData.read(showNewTransactionNotification),
                    onChanged: (value) {
                      appData.write(showNewTransactionNotification, value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Divider(
                  thickness: 1,
                  color: themeController.isDarkMode.value
                      ? AppColors.cardBorderSideColorDark.withOpacity(1)
                      : AppColors.cardBorderSideColorLight,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: ListTile(
                  title: Text(
                    'Daily Reminder Notification',
                    style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? AppColors.titleTextColorDark
                            : AppColors.titleTextColorLight),
                  ),
                  trailing: Switch(
                    activeColor: AppColors.appBarFillColor,
                    inactiveThumbColor: themeController.isDarkMode.value == true
                        ? AppColors.chartBarBackgroundColorDark
                        : AppColors.chartBarBackgroundColorLight,
                    inactiveTrackColor: themeController.isDarkMode.value == true
                        ? AppColors.chartBarBackgroundColorDark
                        : AppColors.chartBarBackgroundColorLight,
                    value: appData.read(showReminderNotification),
                    onChanged: (value) {
                      appData.write(showReminderNotification, value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Divider(
                  thickness: 1,
                  color: themeController.isDarkMode.value
                      ? AppColors.cardBorderSideColorDark.withOpacity(1)
                      : AppColors.cardBorderSideColorLight,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                ),
                child: NotificationCategoriesDisplay(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Divider(
                  thickness: 1,
                  color: themeController.isDarkMode.value
                      ? AppColors.cardBorderSideColorDark.withOpacity(1)
                      : AppColors.cardBorderSideColorLight,
                ),
              ),
            ],
          ))),
    );
  }
}
