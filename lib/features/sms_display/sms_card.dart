
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/new_transaction_controller.dart';
import '../../controllers/sms_controller.dart';
import '../../models/sms.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import 'package:get/get.dart';

class SMSCard extends StatelessWidget {
  final Function refresh;
  final SMS sms;
  SMSCard(this.sms, this.refresh, {super.key});

  final HomePageController homePageController = Get.find();

  final NewTransactionController newTransactionController = Get.put(NewTransactionController());

  final SmsController smsAndDbController = Get.find();
  final ThemeController themeController = Get.find();

  String checkCreditedDebited(String smsBody) {
    var list = smsBody.split(' ');
    for (var element in list) {
      if (element.contains('debited')) {
        return 'Expense';
      } else if (element.contains('credited')) {
        return 'Income';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 80,
                horizontal: MediaQuery.of(context).size.width / 22.5),
            child: InkWell(
              onTap: (() {
                final smsBody = sms.body.toLowerCase();

                newTransactionController.currDate.value = sms.time;

                newTransactionController.accountChoice.value = smsBody.contains('upi') ? 2 : 3;

                newTransactionController.typeChoice.value =
                    checkCreditedDebited(smsBody) == 'Income' ? 1 : 2;

                String amount = '';
                RegExp exp = RegExp(r"[-+]?\d*\.\d+|\d+");

                for (var word in smsBody.split(' ')) {
                  if (isFloat(word)) {
                    amount = word;
                    break;
                  } else if (isInt(word)) {
                    amount = word;
                    break;
                  } else if (exp.hasMatch(word) && (word.contains('rs') || word.contains('inr'))) {
                    var extracted = exp.firstMatch(word);
                    amount = extracted!.group(0)!;
                    if (amount[0] == '.') {
                      amount = amount.substring(1);
                    }
                    break;
                  }
                }

                newTransactionController.amountController.value.text = amount;

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return homePageController.startAddNewTransaction(context, sms);
                  },
                ).then((value) {
                  newTransactionController.currDate.value = DateTime.now();
                  newTransactionController.accountChoice.value = 0;
                  newTransactionController.typeChoice.value = 0;
                  newTransactionController.titleController.value = TextEditingController();
                  newTransactionController.amountController.value = TextEditingController();
                  newTransactionController.currCategoryTitle.value = "";
                  refresh();
                });
              }),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(
                        color: themeController.isDarkMode.value
                            ? AppColors.cardBorderSideColorDark
                            : AppColors.cardBorderSideColorLight,
                        width: 1),
                  ),
                  elevation: 0,
                  color: themeController.isDarkMode.value
                      ? sms.added
                          ? AppColors.cardBackgroundColorDark.withAlpha(0)
                          : AppColors.cardBackgroundColorDark.withAlpha(255)
                      : sms.added
                          ? AppColors.cardBackgroundColorLight
                          : AppColors.cardBackgroundColorLight.withAlpha(0),
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width / 50),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sms.sender,
                            style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? AppColors.titleTextColorDark
                                    : AppColors.titleTextColorLight),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Text(
                            DateFormat('HH:mm     dd/MM/yyyy').format(sms.time),
                            style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? AppColors.subtitleTextColorDark
                                    : AppColors.titleTextColorLight),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            child: InkWell(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: ((context) {
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
                                      title: Text(
                                        'Do you want to block ${sms.sender}?',
                                        style: TextStyle(
                                            color: themeController.isDarkMode.value
                                                ? AppColors.titleTextColorDark
                                                : AppColors.titleTextColorLight),
                                      ),
                                      content: Text(
                                        "If blocked, messages from this sender will not appear in this list. However, you will still be able to read those messages in your Messages app.",
                                        style: TextStyle(
                                          color: themeController.isDarkMode.value
                                              ? AppColors.subtitleTextColorDark
                                              : AppColors.subtitleTextColorLight,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: themeController.isDarkMode.value
                                                  ? AppColors.titleTextColorDark
                                                  : AppColors.titleTextColorLight,
                                            ),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                              color: themeController.isDarkMode.value
                                                  ? AppColors.titleTextColorDark
                                                  : AppColors.titleTextColorLight,
                                            ),
                                          ),
                                          onPressed: () {
                                            smsAndDbController.addSender(sms.sender);
                                            Navigator.pop(context);
                                            refresh();
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              },
                              child: Icon(
                                Icons.block,
                                size: 25,
                                color: AppColors.deleteIconColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      subtitle: Text(
                        sms.body,
                        style: TextStyle(
                            color: themeController.isDarkMode.value
                                ? AppColors.subtitleTextColorDark
                                : AppColors.titleTextColorLight),
                      ),
                    ),
                  )),
            ),
          )),
    );
  }
}
