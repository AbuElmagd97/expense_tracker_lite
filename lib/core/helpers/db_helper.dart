import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/dashboard/data/models/expense_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
  CREATE TABLE expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category TEXT,
    amount REAL,
    currency TEXT,
    convertedAmount REAL,
    time TEXT,
    icon INTEGER,
    color INTEGER
  )
''');
      },
    );
  }

  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return maps.map((e) => Expense.fromMap(e)).toList();
  }

  /// New method to get expenses paged with optional month filter (filterMonth format: "YYYY-MM")
  Future<List<Expense>> getExpensesPaged({
    required int offset,
    required int limit,
    String? filterMonth,
  }) async {
    final db = await database;
    String whereString = '';
    List<dynamic> whereArgs = [];

    if (filterMonth != null && filterMonth.isNotEmpty) {
      whereString = 'time LIKE ?';
      whereArgs = ['$filterMonth%']; // e.g., '2025-05%'
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: whereString.isEmpty ? null : whereString,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'time DESC',
      limit: limit,
      offset: offset,
    );

    return maps.map((e) => Expense.fromMap(e)).toList();
  }

  Future<void> clearExpenses() async {
    final db = await database;
    await db.delete('expenses');
  }
}
