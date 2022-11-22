import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_expenses/controllers/theme_controller.dart';
import 'widgets/my_home_page.dart';
import './themes/app_themes.dart';

void main() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255),
    ),
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController c = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    c.appData.writeIfNull("darkmode", false);
    return SimpleBuilder(builder: (_) {
      c.isDarkMode.value = c.appData.read("darkmode");
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: c.isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme,
        title: 'Personal Expenses',
        home: MyHomePage(),
      );
    });
  }
}
