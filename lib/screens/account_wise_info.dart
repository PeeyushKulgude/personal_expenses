import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/controllers/account_info_controller.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/features/account_wise_info/time_interval_selector.dart';

import '../themes/app_colors.dart';
import '../features/account_wise_info/account_info_tile.dart';
import '../features/appbar/custom_appbar.dart';
import 'navigation_drawer.dart';

class AccountWiseInfoPage extends StatefulWidget {

  const AccountWiseInfoPage({super.key});

  @override
  State<AccountWiseInfoPage> createState() => _AccountWiseInfoPageState();
}

class _AccountWiseInfoPageState extends State<AccountWiseInfoPage> {
  final ThemeController themeController = Get.find();

  final AccountInfoController accountInfoController = Get.find();

  @override
  void initState() {
    accountInfoController.getAccountWiseTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Payment Methods'),
      drawer: CustomNavigationDrawer(),
      body: GetBuilder<AccountInfoController>(builder: (accountInfoController) {
        if (accountInfoController.pageState.value == AppState.loaded) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: AccountInfoTimeIntervalSelector(),
                ),
                AccountInfoTile(
                  title: 'Cash',
                  iconAddress: 'assets/images/cash.svg',
                  income: accountInfoController.accountWiseTotal['cash']!['income'] ?? 0.0,
                  expense: accountInfoController.accountWiseTotal['cash']!['expense'] ?? 0.0,
                ),
                Divider(
                  thickness: 1,
                  color: themeController.isDarkMode.value
                      ? AppColors.cardBorderSideColorDark.withOpacity(1)
                      : AppColors.cardBorderSideColorLight,
                ),
                AccountInfoTile(
                  title: 'UPI',
                  iconAddress: 'assets/images/upi.svg',
                  income: accountInfoController.accountWiseTotal['upi']!['income'] ?? 0.0,
                  expense: accountInfoController.accountWiseTotal['upi']!['expense'] ?? 0.0,
                ),
                Divider(
                  thickness: 1,
                  color: themeController.isDarkMode.value
                      ? AppColors.cardBorderSideColorDark.withOpacity(1)
                      : AppColors.cardBorderSideColorLight,
                ),
                AccountInfoTile(
                  title: 'Card',
                  iconAddress: 'assets/images/debitcard.svg',
                  income: accountInfoController.accountWiseTotal['card']!['income'] ?? 0.0,
                  expense: accountInfoController.accountWiseTotal['card']!['expense'] ?? 0.0,
                ),
              ],
            ),
          );
        } else if (accountInfoController.pageState.value == AppState.loading) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: themeController.isDarkMode.value
                  ? AppColors.iconColor1Dark
                  : AppColors.iconColor1Light,
              size: 50,
            ),
          );
        } else if (accountInfoController.pageState.value == AppState.initial) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: themeController.isDarkMode.value
                  ? AppColors.iconColor1Dark
                  : AppColors.iconColor1Light,
              size: 50,
            ),
          );
        }
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: themeController.isDarkMode.value
                ? AppColors.iconColor1Dark
                : AppColors.iconColor1Light,
            size: 50,
          ),
        );
      }),
    );
  }
}
