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
  String amount = '';
  String smsType = checkCreditedDebited(smsBody);
  var filteredCategoryList = categoryList
      .where(
        (element) => element.categoryType == smsType,
      )
      .toList();

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

  if (amount != '' && filteredCategoryList.isNotEmpty && smsType.isNotEmpty) {
    log({
      'amount': amount,
      'date': sms.date!.toString(),
      'type': checkCreditedDebited(smsBody),
      'account': (smsBody.contains('upi') ? 'UPI' : 'DebitCard'),
      filteredCategoryList[0].title: filteredCategoryList[0].iconCode.toString(),
      filteredCategoryList[1].title: filteredCategoryList[1].iconCode.toString(),
      'Other': Icons.mail_outline_rounded.codePoint.toString(),
    }.toString());
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
          'Other': Icons.mail_outline_rounded.codePoint.toString(),
        },
      ),
      actionButtons: [
        NotificationActionButton(
          buttonType: ActionButtonType.Default,
          key: filteredCategoryList[0].title,
          label: filteredCategoryList[0].title,
          icon: CategoryIcons.notificationIconData[filteredCategoryList[0].iconCode],
        ),
        NotificationActionButton(
          buttonType: ActionButtonType.Default,
          key: filteredCategoryList[1].title,
          label: filteredCategoryList[1].title,
          icon: CategoryIcons.notificationIconData[filteredCategoryList[1].iconCode],
        ),
        NotificationActionButton(
          buttonType: ActionButtonType.Default,
          key: 'Other',
          label: 'Other',
          icon: CategoryIcons.notificationIconData[filteredCategoryList[1].iconCode],
        ),
      ],
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
