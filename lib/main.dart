import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_expenses/controllers/account_info_controller.dart';
import 'package:personal_expenses/controllers/new_transaction_controller.dart';
import 'package:personal_expenses/controllers/sms_controller.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'package:personal_expenses/database/transaction_database.dart';
import 'package:personal_expenses/models/category.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'controllers/home_page_controller.dart';
import 'models/blocked_sender.dart';
import 'screens/my_home_page.dart';
import './themes/app_themes.dart';
import 'package:workmanager/workmanager.dart';
import './database/simple_preferences.dart';
import 'features/notifications/notifications.dart';

const taskName1 = 'checkMessages';
const taskName2 = 'dailyReminder';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await GetStorage.init();
    final appData = GetStorage();
    switch (task) {
      case taskName1:
        if (await Permission.sms.status.isGranted && appData.read(showNewTransactionNotification)) {
          final SmsQuery query = SmsQuery();
          appData.writeIfNull(lastTimeSMSChecked,
              DateTime.now().subtract(const Duration(hours: 24)).toIso8601String());
          DateTime stopTime = DateTime.parse(appData.read(lastTimeSMSChecked));
          // DateTime stopTime = DateTime.now().subtract(const Duration(hours: 24));
          SmsController smsController = Get.put(SmsController());
          List<BlockedSender> blockedSenderList = smsController.blockedSendersList;
          List<Category>? categoryList = await smsController.getNotificationCategories();

          final messages = await query.querySms(
            kinds: [SmsQueryKind.inbox],
          );
          for (var element in messages) {
            if (element.date!.isAfter(stopTime)) {
              if (smsFilter(element, blockedSenderList)) {
                showTransactionDetectedNotification(element, categoryList!);
              }
            } else {
              break;
            }
          }
        }
        appData.write(lastTimeSMSChecked, DateTime.now().toIso8601String());
        break;
      case taskName2:
        if (appData.read(showReminderNotification)) {
          showDailyReminderNotification();
        }
        break;
      default:
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  AwesomeNotifications().initialize('resource://drawable/res_notification_icon', [
    NotificationChannel(
      channelKey: 'new_sms_detected',
      channelName: 'New Transaction Detected',
      channelDescription: 'Notification which is shown when a new transaction is detected.',
      defaultColor: const Color.fromRGBO(122, 195, 168, 1),
    ),
    NotificationChannel(
      channelKey: 'daily_reminder',
      channelName: 'Daily Reminders',
      channelDescription: 'Daily reminder notifications.',
      defaultColor: const Color.fromRGBO(122, 195, 168, 1),
    ),
  ]);

  AwesomeNotifications().actionStream.listen((event) async {
    HomePageController homePageController = Get.put(HomePageController());
    if (event.buttonKeyPressed != 'Other') {
      DateTime date = DateTime.parse(event.payload!['date']!);
      await TransactionDatabase.instance.create(
        Transaction(
          title: event.buttonKeyPressed,
          amount: double.parse(event.payload!['amount']!),
          date: DateTime(date.year, date.month, date.day),
          type: event.payload!['type']!,
          account: event.payload!['account']!,
          category: event.buttonKeyPressed,
          iconCode: int.parse(event.payload![event.buttonKeyPressed]!),
          categoryType: event.payload!['type']!,
        ),
      );
      homePageController.getDatewiseGroupedTransactions();
      homePageController.incomeAndExpenseMonthlyTotal();
    } else {
      homePageController.addOtherTransactionFromNotification(event.payload!);
    }
  });

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
    ),
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  final NewTransactionController _newTransactionController = Get.put(NewTransactionController());

  final SmsController _smsController = Get.put(SmsController());

  // ignore: unused_field
  final HomePageController _homePageController = Get.put(HomePageController());

  // ignore: unused_field
  final AccountInfoController _accountInfoController = Get.put(AccountInfoController());

  @override
  Widget build(BuildContext context) {
    if (_themeController.appData.read(darkmode) == null) {
      _themeController.appData.writeIfNull(darkmode, true);
      _themeController.appData.writeIfNull(showNewTransactionNotification, true);
      _themeController.appData.writeIfNull(showReminderNotification, true);
      _newTransactionController.addDefaultCategories();
      _smsController.addNotificationCategories();
      Workmanager().registerPeriodicTask(
        DateTime.now().second.toString(),
        taskName1,
        frequency: const Duration(minutes: 15),
        initialDelay: const Duration(minutes: 5),
        existingWorkPolicy: ExistingWorkPolicy.append,
      );
      Workmanager().registerPeriodicTask(
        DateTime.now().second.toString(),
        taskName2,
        frequency: const Duration(hours: 24),
        initialDelay: const Duration(minutes: 10),
        existingWorkPolicy: ExistingWorkPolicy.append,
      );
    }
    return SimpleBuilder(builder: (_) {
      _themeController.isDarkMode.value = _themeController.appData.read(darkmode);
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeController.isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme,
        title: 'Personal Expenses',
        home: const MyHomePage(),
      );
    });
  }
}
