import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'navigation_drawer.dart';
import '../controllers/sms_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import '../controllers/new_transaction_controller.dart';
import '../controllers/home_page_controller.dart';
import 'package:string_validator/string_validator.dart';

class SmsDisplay extends StatelessWidget {
  SmsDisplay({super.key});

  final HomePageController homePageController = Get.find();
  final NewTransactionController newTransactionController =
      Get.put(NewTransactionController());

  @override
  Widget build(BuildContext context) {
    final SmsDbAndController c = Get.put(SmsDbAndController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      appBar: AppBar(
        title: const Text(
          'Inbox Messages',
        ),
        backgroundColor: const Color.fromARGB(255, 179, 3, 3),
      ),
      drawer: const NavigationDrawer(),
      body: FutureBuilder(
          future: c.getAllMessages(),
          builder: (context, AsyncSnapshot<List<SmsMessage>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white, size: 50),
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
                            vertical: MediaQuery.of(context).size.width / 30,
                            horizontal: MediaQuery.of(context).size.width / 15),
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
                                if (smsBody[i] == '.' && isInt(smsBody[i-1])) {
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
                            newTransactionController
                                .amountController.value.text = amount;

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
                              newTransactionController.currCategory.value = "";
                            });
                          }),
                          child: Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 50),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${sms.sender}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      DateFormat('HH:mm     dd/MM/yyyy')
                                          .format(sms.date as DateTime),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  '${sms.body}',
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(125, 255, 255, 255)),
                                ),
                              )),
                        ),
                      );
                    });
              }
            }
            return Container();
          }),
    );
  }
}
