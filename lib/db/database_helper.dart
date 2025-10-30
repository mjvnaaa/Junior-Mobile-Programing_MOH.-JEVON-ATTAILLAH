import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bread_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB); 
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      customerName TEXT,
      phoneNumber TEXT,
      breadName TEXT,
      quantity INTEGER,
      latitude REAL,
      longitude REAL
    )
    ''');
  }

  Future<int> insertOrder(Map<String, dynamic> order) async {
    final db = await instance.database;
    return await db.insert('orders', order);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await instance.database;
    return await db.query('orders');
  }
}