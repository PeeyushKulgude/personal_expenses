import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';

import '../themes/app_colors.dart';
import '../features/animations/buy_me_a_coffee.dart';
import '../features/appbar/custom_appbar.dart';
import 'navigation_drawer.dart';

class BuyMeACoffeePage extends StatelessWidget {
  final ThemeController themeController = Get.find();

  BuyMeACoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Buy Me A Coffee'),
      drawer: CustomNavigationDrawer(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuyMeACoffeeAnimation(),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/qr.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom, left: 16, right: 16, top: 16),
                child: Text(
                  textAlign: TextAlign.center,
                  'As a student and an independent developer, I have spent 5 months making this app. All of its features are free and always will be.\n\nIf you found my work to be useful and would like to support me, consider buying me a coffee.\n\nBy buying me a coffee, you\'re not just supporting me financially, you\'re also helping me to continue doing what I love. Every little bit helps, and I\'m incredibly grateful for your generosity.',
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.titleTextColorDark
                        : AppColors.titleTextColorLight,
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
