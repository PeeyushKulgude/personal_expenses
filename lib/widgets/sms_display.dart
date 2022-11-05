import 'package:flutter/material.dart';
import 'navigation_drawer.dart';
import '../controllers/sms_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import '../controllers/new_transaction_controller.dart';
import '../controllers/home_page_controller.dart';

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
      body: Obx(
        (() => c.allMessages.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 120,
                child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white, size: 50)),
              )
            : SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: c.allMessages.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    var message = c.allMessages[i];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width / 30,
                          horizontal: MediaQuery.of(context).size.width / 15),
                      child: InkWell(
                        onTap: (() {
                          final splittedMessage =
                              message.body!.toLowerCase().split(' ');

                          newTransactionController.currDate.value =
                              message.date!;

                          newTransactionController.accountChoice.value =
                              splittedMessage.contains('upi') ? 2 : 3;

                          newTransactionController.typeChoice.value =
                              splittedMessage.contains('credited') ? 1 : 2;

                          for (int i = 0; i < splittedMessage.length; i++) {
                            if (splittedMessage[i].length > 3) {
                              if (splittedMessage[i].substring(0, 3) == 'rs.') {
                                for (int j = 3;
                                    j < splittedMessage[i].length;
                                    j++) {
                                  if (splittedMessage[i][j] != '.') {
                                    newTransactionController.amountController
                                        .value.text += splittedMessage[i][j];
                                  } else {
                                    break;
                                  }
                                }
                                break;
                              } else if (splittedMessage[i].substring(0, 2) ==
                                  'rs') {
                                for (int j = 2;
                                    j < splittedMessage[i].length;
                                    j++) {
                                  if (splittedMessage[i][j] != '.') {
                                    newTransactionController.amountController
                                        .value.text += splittedMessage[i][j];
                                  } else {
                                    break;
                                  }
                                }
                                break;
                              }
                            }
                          }

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
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${message.sender}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  DateFormat('HH:mm     dd/MM/yyyy')
                                      .format(message.date as DateTime),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              '${message.body}',
                              style: const TextStyle(
                                  color: Color.fromARGB(125, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
      ),
    );
  }
}
