import 'dart:math';

import 'package:get/get.dart';
import 'package:personal_expenses/database/categories_database.dart';
import 'package:personal_expenses/models/category.dart';
import '../database/transaction_database.dart';

class StatisticsController extends GetxController {
  var categoryList = <Category>[].obs;
  Random random = Random();

  Future<Map<String, double>?>? findCategorySum() async {
    var list = (await TransactionDatabase.instance.findCategorySum());
    if (list != null) {
      var categoryWiseList = <String, double>{};
      categoryList.value = [];
      for (int i = 0; i < list.length; i++) {
        categoryWiseList[list[i]['category'] as String] = (list[i]['SUM (amount)'] as double);
        getCategory(list[i]['category'] as String);
      }
      return categoryWiseList;
    }
    return null;
  }

  void getCategory(String name) async {
    categoryList.add(await CategoryDatabase.instance.getCategory(name));
  }
}
