import 'package:path/path.dart';
import 'package:personal_expenses/database/sms_database.dart';
import 'package:sqflite/sqflite.dart';
import '../models/blocked_sender.dart';

class BlockedSenderDatabase {
  static final BlockedSenderDatabase instance = BlockedSenderDatabase._init();

  static Database? _database;

  BlockedSenderDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('blockedsender.db');
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
CREATE TABLE $tableBlockedSenders (
  ${BlockedSenderFields.id} $idType,
  ${BlockedSenderFields.sender} $textType
  )
''');
  }

  Future<BlockedSender> create(BlockedSender blockedSender) async {
    final db = await instance.database;
    final id = await db.insert(tableBlockedSenders, blockedSender.toJson());
    SMSDatabase.instance.blockSender(blockedSender.sender);
    return blockedSender.copy(id: id);
  }

  Future<List<BlockedSender>?> readAllBlockedSenders() async {
    final db = await instance.database;

    const orderBy = '${BlockedSenderFields.id} DESC';
    var map = await db.query(tableBlockedSenders, orderBy: orderBy);
    if (map.isNotEmpty) {
      return map.map((e) => BlockedSender.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBlockedSenders,
      where: '${BlockedSenderFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
