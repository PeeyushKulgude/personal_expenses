const String tableTransactions = 'transactions';

class TransactionFields {
  static final List<String> values = [
    id,
    title,
    amount,
    date,
    amount,
    date,
    type,
    account,
    category,
    iconCode,
    categoryType
  ];
  static const String id = '_id';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String date = 'date';
  static const String type = 'type';
  static const String account = 'account';
  static const String category = 'category';
  static const String iconCode = 'iconCode';
  static const String categoryType = 'categoryType';
}

class Transaction {
  final int? id;
  final String title;
  final int amount;
  final DateTime date;
  final String type;
  final String account;
  final String category;
  final int iconCode;
  final String categoryType;

  Transaction(
      {this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.type,
      required this.account,
      required this.category,
      required this.iconCode,
      required this.categoryType});

  Map<String, Object?> toJson() {
    return {
      TransactionFields.id: id,
      TransactionFields.title: title,
      TransactionFields.amount: amount,
      TransactionFields.date: date.toIso8601String(),
      TransactionFields.type: type,
      TransactionFields.account: account,
      TransactionFields.category: category,
      TransactionFields.iconCode: iconCode,
      TransactionFields.categoryType: categoryType,
    };
  }

  Transaction copy({
    int? id,
    String? title,
    int? amount,
    DateTime? date,
    String? type,
    String? account,
    String? category,
    int? iconCode,
    String? categoryType,
  }) =>
      Transaction(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        type: type ?? this.type,
        account: account ?? this.account,
        category: category ?? this.category,
        iconCode: iconCode ?? this.iconCode,
        categoryType: categoryType ?? this.categoryType,
      );

  static Transaction fromJson(Map<String, dynamic> json) => Transaction(
        id: json[TransactionFields.id] as int,
        title: json[TransactionFields.title] as String,
        amount: json[TransactionFields.amount] as int,
        date: DateTime.parse(json[TransactionFields.date] as String),
        type: json[TransactionFields.type] as String,
        account: json[TransactionFields.account] as String,
        category: json[TransactionFields.category] as String,
        iconCode: json[TransactionFields.iconCode] as int,
        categoryType: json[TransactionFields.categoryType] as String,
      );
}
