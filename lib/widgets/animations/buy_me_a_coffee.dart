import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/theme_controller.dart';

class BuyMeACoffeeAnimation extends StatelessWidget {
  final ThemeController themeController = Get.find();

  BuyMeACoffeeAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(
            'assets/animations/buy_me_a_coffee.json',
          ),
        ],
      ),
    );
  }
}
