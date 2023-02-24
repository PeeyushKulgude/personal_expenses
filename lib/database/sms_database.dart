import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/sms.dart';

class SMSDatabase {
  static final SMSDatabase instance = SMSDatabase._init();

  static Database? _database;

  SMSDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sms.db');
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
CREATE TABLE $tableSms (
  ${SMSFields.id} $idType,
  ${SMSFields.sender} $textType,
  ${SMSFields.body} $textType,
  ${SMSFields.time} $textType,
  ${SMSFields.added} $textType
  )
''');
  }

  Future<SMS> create(SMS sms) async {
    final db = await instance.database;
    final id = await db.insert(tableSms, sms.toJson());
    return sms.copy(id: id);
  }

  Future<List<SMS>?> readAllSMS() async {
    final db = await instance.database;

    const orderBy = '${SMSFields.time} DESC';
    var map = await db.query(tableSms, orderBy: orderBy, limit: 50);
    if (map.isNotEmpty) {
      return map.map((e) => SMS.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSms,
      where: '${SMSFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> blockSender(String sender) async {
    final db = await instance.database;

    return await db.delete(
      tableSms,
      where: '${SMSFields.sender} = ?',
      whereArgs: [sender],
    );
  }

  void added(SMS sms) async {
    sms.added = true;
    final db = await instance.database;
    db.update(
      tableSms,
      sms.toJson(),
      where: '${SMSFields.id} = ?',
      whereArgs: [sms.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
