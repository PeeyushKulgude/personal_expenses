import 'package:flutter/material.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import '../../controllers/theme_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controllers/home_page_controller.dart';

class DateHeader extends StatelessWidget {
  final DateTime date;
  DateHeader(this.date, {super.key});
  final ThemeController themeController = Get.find();
  final HomePageController homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
            height: MediaQuery.of(context).size.height / 22,
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: themeController.isDarkMode.value
                  ? AppColors.dayHeaderContainerBackgroundColorDark
                  : AppColors.dayHeaderContainerBackgroundColorLight,
              border: Border.all(
                  color: themeController.isDarkMode.value
                  ? AppColors.dayHeaderContainerBorderColorDark
                  : AppColors.dayHeaderContainerBorderColorLight, width: 1),
            ),
            child: FittedBox(
              child: Text(
                DateFormat('EEE').format(date),
                style: TextStyle(
                    color: themeController.isDarkMode.value
                  ? AppColors.dayHeaderContainerTextColorDark
                  : AppColors.dayHeaderContainerTextColorLight,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 20,
          ),
          Text(
            DateFormat('dd MMM yyyy').format(date),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: themeController.isDarkMode.value
                  ? AppColors.dayHeaderDateTextColorDark
                  : AppColors.dayHeaderDateTextColorLight,
            ),
          )
        ],
      ),
    );
  }
}
