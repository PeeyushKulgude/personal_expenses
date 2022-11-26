import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/transaction.dart' as t;

class TransactionDatabase {
  static final TransactionDatabase instance = TransactionDatabase._init();

  static Database? _database;

  TransactionDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE ${t.tableTransactions} (
  ${t.TransactionFields.id} $idType,
  ${t.TransactionFields.title} $textType,
  ${t.TransactionFields.amount} $integerType,
  ${t.TransactionFields.date} $textType,
  ${t.TransactionFields.type} $textType,
  ${t.TransactionFields.account} $textType,
  ${t.TransactionFields.category} $textType,
  ${t.TransactionFields.iconCode} $integerType,
  ${t.TransactionFields.categoryType} $textType
  )
''');
  }

  Future<t.Transaction> create(t.Transaction transaction) async {
    final db = await instance.database;
    final id = await db.insert(t.tableTransactions, transaction.toJson());
    return transaction.copy(id: id);
  }

  Future<List<t.Transaction>?> readAllTransactions() async {
    final db = await instance.database;

    const orderBy = '${t.TransactionFields.date} DESC';
    final map = await db.query(t.tableTransactions, orderBy: orderBy);

    if (map.isNotEmpty) {
      return map.map((e) => t.Transaction.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> datewiseTransactions() async {
    final db = await instance.database;
    List<Map<String, dynamic>> lst = [];

    final d = await db.rawQuery(
        "SELECT DISTINCT ${t.TransactionFields.date} FROM ${t.tableTransactions} ORDER BY ${t.TransactionFields.date} DESC");
    for (int i = 0; i < d.length; i++) {
      final transactions = await db.query(t.tableTransactions,
          columns: t.TransactionFields.values,
          where: '${t.TransactionFields.date} = ?',
          whereArgs: [d[i]['date']]);
      lst.add({
        'date': DateTime.parse(d[i]['date'] as String),
        'transactions': List.generate(transactions.length,
            (index) => t.Transaction.fromJson(transactions[index])),
      });
    }
    return lst;
  }

  Future<List<Map<String, Object?>>?> findCategorySum() async {
    final db = await instance.database;

    final map = await db.rawQuery(
        "SELECT ${t.TransactionFields.category}, SUM (${t.TransactionFields.amount}) FROM ${t.tableTransactions} WHERE ${t.TransactionFields.type} = 'Expense' GROUP BY ${t.TransactionFields.category};");
    if (map.isNotEmpty) {
      return map;
    } else {
      return null;
    }
  }

  Future<t.Transaction?> readTransaction(int id) async {
    final db = await instance.database;

    final map = await db.query(t.tableTransactions,
        columns: t.TransactionFields.values,
        where: '${t.TransactionFields.id} = ?',
        whereArgs: [id]);

    if (map.isNotEmpty) {
      return t.Transaction.fromJson(map.first);
    } else {
      return null;
    }
  }

  Future<int> update(int id, t.Transaction transaction) async {
    final db = await instance.database;
    return db.update(
      t.tableTransactions,
      transaction.toJson(),
      where: '${t.TransactionFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      t.tableTransactions,
      where: '${t.TransactionFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
