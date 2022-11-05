import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsDbAndController extends GetxController {
  final SmsQuery _query = SmsQuery();
  var allMessages = <SmsMessage>[].obs;

  SmsDbAndController() {
    getAllMessages();
  }

  void checkMessage(SmsMessage message) {
    String lst = message.body!.toLowerCase();
    if ((lst.contains('credited') || lst.contains('debited')) &&
        !lst.contains('recharge') &&
        !lst.contains('offers') &&
        !lst.contains('free') &&
        !lst.contains('requested')) {
      allMessages.add(message);
    }
  }

  void getAllMessages() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
      );

      for (int i = 0; i < messages.length; i++) {
        checkMessage(messages[i]);
      }
    } else {
      await Permission.sms.request();
    }
  }
}
