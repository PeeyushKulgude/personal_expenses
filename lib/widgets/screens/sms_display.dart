import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import 'navigation_drawer.dart';
import '../../controllers/sms_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../controllers/home_page_controller.dart';
import 'package:string_validator/string_validator.dart';

class SmsDisplay extends StatelessWidget {
  SmsDisplay({super.key});

  final HomePageController homePageController = Get.find();
  final NewTransactionController newTransactionController =
      Get.put(NewTransactionController());

  @override
  Widget build(BuildContext context) {
    final SmsAndDbController smsAndDbController = Get.put(SmsAndDbController());
    final ThemeController themeController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: TextStyle(
            color: themeController.isDarkMode.value
                ? AppColors.titleTextColorDark
                : AppColors.titleTextColorLight,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (() {
              themeController.isDarkMode.value =
                  !themeController.isDarkMode.value;
              themeController.changeTheme();
            }),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
              child: themeController.isDarkMode.value
                  ? Icon(
                      Icons.sunny,
                      key: const ValueKey('icon1'),
                      color: AppColors.appBarIconColorDark,
                    )
                  : Icon(
                      CupertinoIcons.moon_stars_fill,
                      key: const ValueKey('icon2'),
                      color: AppColors.appBarIconColorLight,
                    ),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 30),
        child: FutureBuilder(
          future: smsAndDbController.getAllMessages(),
          builder: (context, AsyncSnapshot<List<SmsMessage>> snapshot) {
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
                  itemBuilder: (context, index) {
                    final sms = snapshot.data![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width / 45,
                          horizontal: MediaQuery.of(context).size.width / 22.5),
                      child: InkWell(
                        onTap: (() {
                          final smsBody = sms.body!.toLowerCase();

                          newTransactionController.currDate.value = sms.date!;

                          newTransactionController.accountChoice.value =
                              smsBody.contains('upi') ? 2 : 3;

                          newTransactionController.typeChoice.value =
                              smsBody.contains('credited') ? 1 : 2;

                          bool found = false;
                          String amount = '';
                          for (int i = 1; i < smsBody.length; i++) {
                            if (found) {
                              if (smsBody[i] == '.' && isInt(smsBody[i - 1])) {
                                break;
                              } else if (isAlpha(smsBody[i])) {
                                break;
                              } else if (isInt(smsBody[i])) {
                                amount += smsBody[i];
                              }
                            } else if (smsBody[i] == 's' &&
                                smsBody[i - 1] == 'r') {
                              found = true;
                            }
                          }
                          newTransactionController.amountController.value.text =
                              amount;

                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                homePageController
                                    .startAddNewTransaction(context),
                          ).then((value) {
                            newTransactionController.currDate.value =
                                DateTime.now();
                            newTransactionController.accountChoice.value = 0;
                            newTransactionController.typeChoice.value = 0;
                            newTransactionController.titleController.value =
                                TextEditingController();
                            newTransactionController.amountController.value =
                                TextEditingController();
                            newTransactionController.currCategoryTitle.value =
                                "";
                          });
                        }),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              side: BorderSide(
                                  color: themeController.isDarkMode.value
                                      ? AppColors.cardBorderSideColorDark
                                      : AppColors.cardBorderSideColorLight,
                                  width: 1),
                            ),
                            elevation: 10,
                            color: themeController.isDarkMode.value
                                ? AppColors.cardBackgroundColorDark
                                : AppColors.cardBackgroundColorLight,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 50),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${sms.sender}',
                                      style: TextStyle(
                                          color: themeController
                                                  .isDarkMode.value
                                              ? AppColors.titleTextColorDark
                                              : AppColors.titleTextColorLight),
                                    ),
                                    Text(
                                      DateFormat('HH:mm     dd/MM/yyyy')
                                          .format(sms.date as DateTime),
                                      style: TextStyle(
                                          color: themeController
                                                  .isDarkMode.value
                                              ? AppColors.subtitleTextColorDark
                                              : AppColors
                                                  .subtitleTextColorLight),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  '${sms.body}',
                                  style: TextStyle(
                                      color: themeController.isDarkMode.value
                                          ? AppColors.subtitleTextColorDark
                                          : AppColors.subtitleTextColorLight),
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
