import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../controllers/new_transaction_controller.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';

class DateChoice extends StatelessWidget {
  final NewTransactionController c = Get.find();
  final ThemeController themeController = Get.find();

  DateChoice({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => c.presentDatePicker(context)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.325,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: themeController.isDarkMode.value
              ? AppColors.canvasColorDark
              : AppColors.fieldColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/date.svg',
              height: MediaQuery.of(context).size.height * 0.03,
              color: AppColors.appBarFillColor,
            ),
            Obx((() => FittedBox(
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(c.currDate.value).toString(),
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.titleTextColorDark
                          : AppColors.titleTextColorLight,
                    ),
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}
