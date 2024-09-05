import "package:items_list/util/sqlite_dbc.dart";

class LoginRepository {
  final SqliteDbc sqliteDbc;
  LoginRepository({required this.sqliteDbc});

  Future<bool> storeToken(String token) async {
    if (await getToken() != "") {
      return updateToken(token);
    }

    int id = await sqliteDbc.query<int>(
      sql: 'INSERT INTO USER (JWT) VALUES (?)',
      values: [token],
    );
    if (id == 0) {
      return false;
    }
    return true;
  }

  Future<bool> updateToken(String token) async {
    int id = await sqliteDbc.query<int>(
      sql: 'UPDATE USER SET JWT = ?',
      values: [token],
    );
    if (id == 0) {
      return false;
    }
    return true;
  }

  Future<bool> removeToken() async {
    int updatedRows = await sqliteDbc.query(
      sql: 'DELETE FROM USER',
    );
    if (updatedRows == 0) {
      return false;
    }
    return true;
  }

  Future<String> getToken() async {
    List<Map<String, dynamic>> result = await sqliteDbc.query(
      sql: 'SELECT JWT FROM USER',
    );
    if (result.isEmpty) {
      return "";
    }
    return result[0]['JWT'];
  }
}
