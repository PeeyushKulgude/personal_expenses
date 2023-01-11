import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_expenses/database/sms_database.dart';
import 'package:personal_expenses/models/sms.dart';
import '../database/blocked_sender_database.dart';
import '../models/blocked_sender.dart';

class SmsController extends GetxController {
  final SmsQuery _query = SmsQuery();
  var smsList = <SMS>[].obs;
  var blockedSendersList = <BlockedSender>[].obs;

  SmsController() {
    getAllBlockedSenders();
  }

  Future<List<BlockedSender>?> getAllBlockedSenders() async {
    var list = await BlockedSenderDatabase.instance.readAllBlockedSenders();
    if (list != null) {
      blockedSendersList.value = list;
      return list;
    }
    return null;
  }

  Future<List<SMS>?> getAllMessagesFromDB() async {
    var dbList = await SMSDatabase.instance.readAllSMS();
    var deviceList = await getAllMessagesFromDevice();
    if (dbList != null) {
      final first = dbList.first;
      for (var element in deviceList) {
        if (element.date!.isAfter(first.time)) {
          await SMSDatabase.instance.create(SMS(
            sender: element.sender!,
            body: element.body!,
            time: element.date!,
          ));
        } else {
          break;
        }
      }
    } else {
      for (var element in deviceList) {
        await SMSDatabase.instance.create(SMS(
          sender: element.sender!,
          body: element.body!,
          time: element.date!,
        ));
      }
    }
    return SMSDatabase.instance.readAllSMS();
  }

  void added(SMS sms) {
    SMSDatabase.instance.added(sms);
  }

  Future<bool> checkMessage(SmsMessage message) async {
    String lst = message.body!.toLowerCase();
    if ((lst.contains('credited') ||
            lst.contains('debited') ||
            lst.contains('transaction')) &&
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
      var blockedSenderList = await getAllBlockedSenders();
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

  void addSender(String sender) {
    BlockedSenderDatabase.instance.create(BlockedSender(sender: sender));
    getAllBlockedSenders();
  }

  void deleteSender(BlockedSender blockedSender) {
    BlockedSenderDatabase.instance.delete(blockedSender.id!);
    getAllBlockedSenders();
  }

  Future<List<SmsMessage>> getAllMessagesFromDevice() async {
    var permission = await Permission.sms.status;
    var filteredMessages = <SmsMessage>[];
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
      );
      for (int i = 0; i < messages.length; i++) {
        if (await checkMessage(messages[i])) {
          filteredMessages.add(messages[i]);
        }
      }
    } else {
      await Permission.sms.request();
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
      );
      for (int i = 0; i < messages.length; i++) {
        if (await checkMessage(messages[i])) {
          filteredMessages.add(messages[i]);
        }
      }
    }
    return filteredMessages;
  }
}
