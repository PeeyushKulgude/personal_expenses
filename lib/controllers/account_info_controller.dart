import 'package:get/get.dart';
import '../database/transaction_database.dart';

enum AppState { initial, loading, loaded, error, empty, disabled }

class AccountInfoController extends GetxController {
  var accountWiseTotal = {
    'cash': {'income': 0.0, 'expense': 0.0},
    'upi': {'income': 0.0, 'expense': 0.0},
    'card': {'income': 0.0, 'expense': 0.0}
  }.obs;
  var startDate = DateTime(DateTime.now().year, DateTime.now().month).obs;
  var endDate = DateTime.now().obs;

  var pageState = AppState.loaded.obs;

  @override
  void onInit() {
    getAccountWiseTotal();
    super.onInit();
  }

  Future getAccountWiseTotal() async {
    pageState.value = AppState.loading;
    refresh();
    var list = (await TransactionDatabase.instance.readAllTransactions());
    if (list != null) {
      accountWiseTotal['cash']!['income'] = 0.0;
      accountWiseTotal['cash']!['expense'] = 0.0;
      accountWiseTotal['upi']!['income'] = 0.0;
      accountWiseTotal['upi']!['expense'] = 0.0;
      accountWiseTotal['card']!['income'] = 0.0;
      accountWiseTotal['card']!['expense'] = 0.0;

      for (var element in list) {
        if ((element.date.isAfter(startDate.value) && element.date.isBefore(endDate.value)) ||
            element.date.isAtSameMomentAs(endDate.value) ||
            element.date.isAtSameMomentAs(startDate.value)) {
          if (element.account == 'Cash') {
            if (element.type == 'Income') {
              accountWiseTotal['cash']!['income'] =
                  (accountWiseTotal['cash']!['income']! + element.amount);
            } else if (element.type == 'Expense') {
              accountWiseTotal['cash']!['expense'] =
                  (accountWiseTotal['cash']!['expense']! + element.amount);
            }
          } else if (element.account == 'UPI') {
            if (element.type == 'Income') {
              accountWiseTotal['upi']!['income'] =
                  (accountWiseTotal['upi']!['income']! + element.amount);
            } else if (element.type == 'Expense') {
              accountWiseTotal['upi']!['expense'] =
                  (accountWiseTotal['upi']!['expense']! + element.amount);
            }
          } else if (element.account == 'DebitCard') {
            if (element.type == 'Income') {
              accountWiseTotal['card']!['income'] =
                  (accountWiseTotal['card']!['income']! + element.amount);
            } else if (element.type == 'Expense') {
              accountWiseTotal['card']!['expense'] =
                  (accountWiseTotal['card']!['expense']! + element.amount);
            }
          }
        } else if (element.date.isBefore(startDate.value)) {
          break;
        }
      }
    }
    pageState.value = AppState.loaded;
    refresh();
  }
}
