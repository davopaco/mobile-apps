import "package:sqflite/sqflite.dart";

class SqliteDbc {
  late Database _db;

  SqliteDbc._();

  static Future<SqliteDbc> createInstance() async {
    var instance = SqliteDbc._();
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    try {
      _db = await openDatabase(
        'items_manager.db',
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE IF NOT EXISTS USER (JWT TEXT PRIMARY KEY)',
          );
          await db.execute(
            'CREATE TABLE IF NOT EXISTS FAV_ITEMS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME VARCHAR(30) NOT NULL, VENDOR VARCHAR(30) NOT NULL, RATING INTEGER NOT NULL, IMAGE_PATH TEXT NOT NULL)',
          );
        },
      );
    } catch (e) {
      print(e);
      throw Exception('Error initializing database');
    }
  }

  Future<T> query<T>(
      {required String sql, List<dynamic> values = const []}) async {
    try {
      String transactionType = sql.split(" ")[0].toUpperCase();
      if ((transactionType != "SELECT" || transactionType != "DELETE") &&
          values.isEmpty) {
        throw Exception(
            'Values should not be empty for other than select or delete queries.');
      }
      dynamic result;

      switch (transactionType) {
        case 'SELECT':
          result = await _db.rawQuery(sql) as List<Map<String, dynamic>>;
        case 'INSERT':
          result = await _db.rawInsert(sql, values);
        case 'UPDATE':
          result = await _db.rawUpdate(sql, values);
        case 'DELETE':
          result = await _db.rawDelete(sql, values);
        default:
          throw Exception('Invalid transaction type');
      }
      await _db.close();
      return result as T;
    } catch (e) {
      print(e);
      if (T == int) {
        return 0 as T;
      } else {
        return <Map<String, dynamic>>[] as T;
      }
    }
  }

  Future<bool> dropDatabase() async {
    try {
      await deleteDatabase('items_manager.db');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
