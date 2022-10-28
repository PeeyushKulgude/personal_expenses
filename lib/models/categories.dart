const String tableCategories = 'categories';

class CategoryFields {
  static final List<String> values = [id, title];
  static const String id = '_id';
  static const String title = 'title';
}

class Category {
  final int? id;
  final String title;

  Category({
    this.id,
    required this.title,
  });

  Map<String, Object?> toJson() {
    return {
      CategoryFields.id: id,
      CategoryFields.title: title,
    };
  }

  Category copy({
    int? id,
    String? title,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
      );

  static Category fromJson(Map<String, dynamic> json) => Category(
        id: json[CategoryFields.id] as int?,
        title: json[CategoryFields.title] as String,
      );
}
