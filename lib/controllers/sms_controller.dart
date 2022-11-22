import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsAndDbController extends GetxController {
  final SmsQuery _query = SmsQuery();

  bool checkMessage(SmsMessage message) {
    String lst = message.body!.toLowerCase();
    if ((lst.contains('credited') || lst.contains('debited')) &&
        !lst.contains('recharge') &&
        !lst.contains('sale') &&
        !lst.contains('expire') &&
        !lst.contains('offer') &&
        !lst.contains('free') &&
        !lst.contains('requested') &&
        !lst.contains('enjoy') &&
        !lst.contains('rummy') &&
        !lst.contains('claim') &&
        !lst.contains('click') &&
        !lst.contains('get') &&
        !lst.contains('prize')) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<SmsMessage>> getAllMessages() async {
    var permission = await Permission.sms.status;
    var filteredMessages = <SmsMessage>[];
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
      );
      for (int i = 0; i < messages.length; i++) {
        if (checkMessage(messages[i])) {
          filteredMessages.add(messages[i]);
        }
      }
    } else {
      await Permission.sms.request();
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
      );
      for (int i = 0; i < messages.length; i++) {
        if (checkMessage(messages[i])) {
          filteredMessages.add(messages[i]);
        }
      }
    }
    return filteredMessages;
  }
}
