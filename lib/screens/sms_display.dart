import 'package:flutter/material.dart';
import '../models/sms.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/themes/app_colors.dart';
import 'package:personal_expenses/widgets/appbar/custom_appbar.dart';
import '../widgets/animations/no_sms_animation.dart';
import '../widgets/sms_display/blocked_sender_list.dart';
import '../widgets/sms_display/sms_card.dart';
import 'navigation_drawer.dart';
import '../controllers/sms_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/new_transaction_controller.dart';
import '../controllers/home_page_controller.dart';

class SmsDisplay extends StatefulWidget {
  const SmsDisplay({super.key});

  @override
  State<SmsDisplay> createState() => _SmsDisplayState();
}

class _SmsDisplayState extends State<SmsDisplay> {
  final HomePageController homePageController = Get.find();

  final NewTransactionController newTransactionController =
      Get.put(NewTransactionController());

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SmsController smsAndDbController = Get.put(SmsController());
    final ThemeController themeController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar('Add Via SMS'),
      drawer: CustomNavigationDrawer(),
      body: FutureBuilder(
        future: smsAndDbController.getAllMessagesFromDB(),
        builder: (context, AsyncSnapshot<List<SMS>?> snapshot) {
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
                  if (index == 0) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            (() => Text(
                                  'SMS Records',
                                  style: TextStyle(
                                    color: themeController.isDarkMode.value
                                        ? AppColors.titleTextColorDark
                                        : AppColors.titleTextColorLight,
                                    fontSize: 22,
                                  ),
                                )),
                          ),
                        ),
                        SMSCard(sms, refresh),
                      ],
                    );
                  }
                  return SMSCard(sms, refresh);
                },
              );
            } else {
              return NoSMSFoundAnimation();
            }
          }
          return NoSMSFoundAnimation();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.35,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: FloatingActionButton(
          backgroundColor: AppColors.deleteIconColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          onPressed: (() {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: ((context) {
                return BlockedSendersList(refresh);
              }),
            );
          }),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.list_alt_rounded,
                  color: Colors.white,
                ),
              ),
              Text(
                "Black List",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
