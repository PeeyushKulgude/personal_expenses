import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_expenses/controllers/sms_controller.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import '../../../themes/app_colors.dart';

class BlockedSendersList extends StatelessWidget {
  final SmsController smsController = Get.find();
  final ThemeController themeController = Get.find();
  final Function refresh;

  BlockedSendersList(this.refresh, {super.key}) {
    smsController.getAllBlockedSenders();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
            color: themeController.isDarkMode.value
                ? AppColors.cardBorderSideColorDark
                : AppColors.cardBorderSideColorLight,
            width: 1),
      ),
      elevation: 10,
      backgroundColor: themeController.isDarkMode.value
          ? AppColors.alertDialogBackgroundColorDark
          : AppColors.alertDialogBackgroundColorLight,
      title: Text('Blocked List',
          style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: FutureBuilder(
          future: smsController.getAllBlockedSenders(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: themeController.isDarkMode.value
                      ? AppColors.iconColor1Dark
                      : AppColors.iconColor1Light,
                  size: 50,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) => Row(
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: TextStyle(
                              color: themeController.isDarkMode.value
                                  ? AppColors.subtitleTextColorDark
                                  : AppColors.subtitleTextColorLight,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              snapshot.data![index].sender,
                              style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? AppColors.subtitleTextColorDark
                                    : AppColors.subtitleTextColorLight,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                              smsController.deleteSender(
                                snapshot.data![index],
                              );
                              refresh();
                            }),
                            color: AppColors.deleteIconColor,
                            icon: const Icon(Icons.delete_outline_rounded),
                          ),
                        ],
                      )),
                );
              } else {
                return Center(
                  child: Text(
                    'No senders are blocked.',
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? AppColors.subtitleTextColorDark
                          : AppColors.subtitleTextColorLight,
                    ),
                  ),
                );
              }
            }
            return Center(
              child: Text(
                'No senders are blocked.',
                style: TextStyle(
                  color: themeController.isDarkMode.value
                      ? AppColors.subtitleTextColorDark
                      : AppColors.subtitleTextColorLight,
                ),
              ),
            );
          }),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Okay',
            style: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.titleTextColorDark
                  : AppColors.titleTextColorLight,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
