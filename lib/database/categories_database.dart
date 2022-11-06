import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/categories.dart';

class CategoryDatabase {
  static final CategoryDatabase instance = CategoryDatabase._init();

  static Database? _database;

  CategoryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('categories.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
    return database;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableCategories (
  ${CategoryFields.id} $idType,
  ${CategoryFields.title} $textType
  )
''');
  }

  Future<Category> create(Category category) async {
    final db = await instance.database;
    final id = await db.insert(tableCategories, category.toJson());
    return category.copy(id: id);
  }

  Future<List<Category>?> readAllCategories() async {
    final db = await instance.database;

    const orderBy = '${CategoryFields.title} ASC';
    final map = await db.query(tableCategories, orderBy: orderBy);

    if (map.isNotEmpty) {
      return map.map((e) => Category.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<int> update(Category category) async {
    final db = await instance.database;

    return db.update(
      tableCategories,
      category.toJson(),
      where: '${CategoryFields.id} = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCategories,
      where: '${CategoryFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
