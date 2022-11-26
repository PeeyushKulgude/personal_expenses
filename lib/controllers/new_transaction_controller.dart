import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/categories.dart';
import '../database/categories_database.dart';
import '../../controllers/theme_controller.dart';
import '../../themes/app_colors.dart';
import '../widgets/new_transaction/type_choice.dart';

class NewTransactionController extends GetxController {
  var currDate = DateTime.now().obs;
  var accountChoice = 0.obs;
  var typeChoice = 0.obs;
  var titleController = TextEditingController().obs;
  var amountController = TextEditingController().obs;
  var currCategoryTitle = "".obs;
  var currCategoryType = "".obs;
  var currCategoryIconCode = 0.obs;
  var userCategories = <Category>[].obs;

  final ThemeController themeController = Get.put(ThemeController());

  Future<List<Category>?> getSpecificCategories(String title) async {
    var list = (await CategoryDatabase.instance.readSpecificCategories(title));
    if (list != null) {
      return list;
    } else {
      addCategory(
          Category(title: 'Food', iconCode: 1, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Recharge', iconCode: 2, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Household', iconCode: 3, categoryType: 'Expense'));
      addCategory(Category(
          title: 'Entertainment', iconCode: 4, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Education', iconCode: 5, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Beauty', iconCode: 6, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Sport', iconCode: 7, categoryType: 'Expense'));
      addCategory(Category(
          title: 'Transportation', iconCode: 8, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Clothing', iconCode: 9, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Car', iconCode: 10, categoryType: 'Expense'));
      addCategory(Category(
          title: 'Electronics', iconCode: 11, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Travel', iconCode: 12, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Health', iconCode: 13, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Pet', iconCode: 14, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Vegetables', iconCode: 15, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Fruits', iconCode: 16, categoryType: 'Expense'));

      addCategory(
          Category(title: 'Salary', iconCode: 17, categoryType: 'Income'));
      addCategory(
          Category(title: 'Investments', iconCode: 18, categoryType: 'Income'));
      addCategory(
          Category(title: 'Part-time', iconCode: 19, categoryType: 'Income'));
      addCategory(
          Category(title: 'Awards', iconCode: 20, categoryType: 'Income'));
      addCategory(
          Category(title: 'Others', iconCode: 21, categoryType: 'Income'));
      return null;
    }
  }

  Future<List<Category>?> readAllCategories() async {
    var list = (await CategoryDatabase.instance.readAllCategories());
    if (list != null) {
      return list;
    } else {
      addCategory(
          Category(title: 'Food', iconCode: 1, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Recharge', iconCode: 2, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Household', iconCode: 3, categoryType: 'Expense'));
      addCategory(Category(
          title: 'Entertainment', iconCode: 4, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Education', iconCode: 5, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Beauty', iconCode: 6, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Sport', iconCode: 7, categoryType: 'Expense'));
      addCategory(Category(
          title: 'Transportation', iconCode: 8, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Clothing', iconCode: 9, categoryType: 'Expense'));
      addCategory(Category(
          title: 'Electricity', iconCode: 22, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Car', iconCode: 10, categoryType: 'Expense'));
      addCategory(Category(
          title: 'Electronics', iconCode: 11, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Travel', iconCode: 12, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Health', iconCode: 13, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Pet', iconCode: 14, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Vegetables', iconCode: 15, categoryType: 'Expense'));
      addCategory(
          Category(title: 'Fruits', iconCode: 16, categoryType: 'Expense'));

      addCategory(
          Category(title: 'Salary', iconCode: 17, categoryType: 'Income'));
      addCategory(
          Category(title: 'Investments', iconCode: 18, categoryType: 'Income'));
      addCategory(
          Category(title: 'Part-time', iconCode: 19, categoryType: 'Income'));
      addCategory(
          Category(title: 'Awards', iconCode: 20, categoryType: 'Income'));
      addCategory(
          Category(title: 'Others', iconCode: 21, categoryType: 'Income'));
      return null;
    }
  }

  void addCategory(Category category) async {
    await CategoryDatabase.instance.create(category);
    currCategoryIconCode.value = 0;
    currCategoryTitle.value = '';
    currCategoryType.value = '';
  }

  void deleteCategory(int id) async {
    await CategoryDatabase.instance.delete(id);
    currCategoryIconCode.value = 0;
    currCategoryTitle.value = '';
    currCategoryType.value = '';
  }

  void editCategory(Category category) async {
    await CategoryDatabase.instance.update(category);
    currCategoryIconCode.value = 0;
    currCategoryTitle.value = '';
    currCategoryType.value = '';
  }

  void presentDatePicker(BuildContext context) {
    showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            dialogTheme: DialogTheme(
              backgroundColor: themeController.isDarkMode.value
                  ? AppColors.alertDialogBackgroundColorDark
                  : AppColors.alertDialogBackgroundColorLight,
            ),
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 179, 3, 3),
              onPrimary: Colors.white,
              onSurface: Colors.redAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: themeController.isDarkMode.value
                    ? AppColors.titleTextColorDark
                    : AppColors.titleTextColorLight,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value != null) {
          currDate.value = value;
        }
        return;
      },
    );
  }
}
