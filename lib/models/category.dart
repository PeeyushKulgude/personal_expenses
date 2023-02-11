const String tableCategories = 'categories';
const String tableNotificationCategories = 'notificationCategories';

class CategoryFields {
  static final List<String> values = [id, title, iconCode, categoryType];
  static const String id = '_id';
  static const String title = 'title';
  static const String iconCode = 'iconCode';
  static const String categoryType = 'categoryType';
}

class Category {
  final int? id;
  final String title;
  final int iconCode;
  final String categoryType;

  Category({this.id, required this.title, required this.iconCode, required this.categoryType});

  Map<String, Object?> toJson() {
    return {
      CategoryFields.id: id,
      CategoryFields.title: title,
      CategoryFields.iconCode: iconCode,
      CategoryFields.categoryType: categoryType,
    };
  }

  Category copy({
    int? id,
    String? title,
    int? iconCode,
    String? categoryType,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        iconCode: iconCode ?? this.iconCode,
        categoryType: categoryType ?? this.categoryType,
      );

  static Category fromJson(Map<String, dynamic> json) => Category(
        id: json[CategoryFields.id] as int?,
        title: json[CategoryFields.title] as String,
        iconCode: json[CategoryFields.iconCode] as int,
        categoryType: json[CategoryFields.categoryType] as String,
      );
}
