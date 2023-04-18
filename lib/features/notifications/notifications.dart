import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:personal_expenses/database/icons_database.dart';
import 'package:personal_expenses/models/category.dart';
import 'package:string_validator/string_validator.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(1000);
}

bool smsFilter(SmsMessage message, blockedSenderList) {
  String lst = message.body!.toLowerCase();
  if ((lst.contains('credited') || lst.contains('debited') || lst.contains('transaction')) &&
      !lst.contains('recharge') &&
      !lst.contains('sale') &&
      !lst.contains('expire') &&
      !lst.contains('offer') &&
      !lst.contains('free') &&
      !lst.contains('requested') &&
      !lst.contains('enjoy') &&
      !lst.contains('rummy') &&
      !lst.contains('claim') &&
      !lst.contains('get') &&
      !lst.contains('prize')) {
    if (blockedSenderList != null) {
      for (var element in blockedSenderList) {
        if (element.sender == message.sender) {
          return false;
        }
      }
    }
    return true;
  } else {
    return false;
  }
}

String checkCreditedDebited(String smsBody) {
  var list = smsBody.split(' ');
  for (var element in list) {
    if (element.contains('debited')) {
      return 'Expense';
    } else if (element.contains('credited')) {
      return 'Income';
    }
  }
  return 'Expense';
}

Future<void> showTransactionDetectedNotification(
    SmsMessage sms, List<Category> categoryList) async {
  final smsBody = sms.body!.toLowerCase();
  bool found = false;
  String amount = '';
  String smsType = checkCreditedDebited(smsBody);
  var filteredCategoryList = categoryList
      .where(
        (element) => element.categoryType == smsType,
      )
      .toList();
  for (int i = 1; i < smsBody.length; i++) {
    if (found) {
      if (smsBody[i] == '.' && isInt(smsBody[i - 1])) {
        break;
      } else if (isAlpha(smsBody[i])) {
        break;
      } else if (isInt(smsBody[i])) {
        amount += smsBody[i];
      }
    } else if ((smsBody[i] == 's' && smsBody[i - 1] == 'r') ||
        (smsBody[i] == 'r' && smsBody[i - 1] == 'n' && smsBody[i - 2] == 'i')) {
      found = true;
    }
  }
  if (amount != '' && filteredCategoryList.isNotEmpty && smsType.isNotEmpty) {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'new_sms_detected',
        title: 'New Transaction Detected',
        body: '$smsType: ₹$amount. Select category:',
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        fullScreenIntent: true,
        displayOnBackground: true,
        displayOnForeground: true,
        backgroundColor: const Color.fromRGBO(22, 95, 90, 1),
        payload: {
          'amount': amount,
          'date': sms.date!.toString(),
          'type': checkCreditedDebited(smsBody),
          'account': (smsBody.contains('upi') ? 'UPI' : 'DebitCard'),
          filteredCategoryList[0].title: filteredCategoryList[0].iconCode.toString(),
          filteredCategoryList[1].title: filteredCategoryList[1].iconCode.toString(),
          filteredCategoryList[2].title: filteredCategoryList[2].iconCode.toString(),
        },
      ),
      actionButtons: List.generate(
        filteredCategoryList.length,
        (index) {
          return NotificationActionButton(
            buttonType: ActionButtonType.Default,
            key: filteredCategoryList[index].title,
            label: filteredCategoryList[index].title,
            icon: CategoryIcons.notificationIconData[filteredCategoryList[index].iconCode],
          );
        },
      ),
    );
  }
}

Future<void> showDailyReminderNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'daily_reminder',
      title: 'Daily Reminder',
      body: 'Have you added your transactions today?',
      displayOnBackground: true,
      displayOnForeground: true,
      backgroundColor: const Color.fromRGBO(22, 95, 90, 1),
    ),
  );
}
