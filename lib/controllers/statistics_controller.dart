import 'package:get/get.dart';
import 'package:personal_expenses/database/categories_database.dart';
import 'package:personal_expenses/models/category.dart';
import '../database/transaction_database.dart';

enum AppState { initial, loading, loaded, error, empty, disabled }

class StatisticsController extends GetxController {
  var categoryWiseList = <String, double>{}.obs;
  var categoryList = <Category>[].obs;
  var startDate = DateTime(DateTime.now().year, DateTime.now().month).obs;
  var endDate = DateTime.now().obs;

  var pageState = AppState.loaded.obs;

  @override
  void onInit() {
    super.onInit();
    findCategorySum();
  }

  Future findCategorySum() async {
    pageState.value = AppState.loading;
    update();
    categoryList.value = await CategoryDatabase.instance.readExpenseCategories() ?? [];
    var list = (await TransactionDatabase.instance.readExpenseTransactions());
    if (list != null) {
      categoryWiseList.clear();
      for (var element in list) {
        if ((element.date.isAfter(startDate.value) && element.date.isBefore(endDate.value)) ||
            element.date.isAtSameMomentAs(endDate.value) ||
            element.date.isAtSameMomentAs(startDate.value)) {
          if (categoryWiseList.containsKey(element.category)) {
            categoryWiseList[element.category] =
                categoryWiseList[element.category]! + element.amount;
          } else {
            categoryWiseList[element.category] = element.amount;
          }
        } else if (element.date.isBefore(startDate.value)) {
          break;
        }
      }
      pageState.value = AppState.loaded;
      update();
    } else {
      pageState.value = AppState.empty;
      update();
    }
  }

  Future<List<Map<String, dynamic>>> getCategoryAndDatewiseTransactions(String categoryName) async {
    var list = await TransactionDatabase.instance
        .categoryWiseTransactions(categoryName, startDate.value, endDate.value);
    if (list != null) {
      return list;
    } else {
      return [];
    }
  }
}
