import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController{
  var isDarkMode = false.obs;
  final appData = GetStorage();

  void changeTheme() {
    appData.write("darkmode", isDarkMode.value);
  }
}