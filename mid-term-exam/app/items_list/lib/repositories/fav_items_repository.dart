import 'package:items_list/model/item.dart';
import 'package:items_list/util/sqlite_dbc.dart';

class FavItemsRepository {
  final SqliteDbc sqliteDbc;

  FavItemsRepository({required this.sqliteDbc});

  Future<List<Item>> getFavItems() async {
    final response = await sqliteDbc.query(sql: "SELECT * FROM FAV_ITEMS");
    if (response.isNotEmpty) {
      final List<Item> items = [];
      response.forEach((json) {
        items.add(Item(
            id: json["ID"],
            name: json["NAME"],
            vendor: json["VENDOR"],
            rating: json["RATING"],
            imagePath: json["IMAGE_PATH"]));
      });
      print(items);
      return items;
    } else {
      return [];
    }
  }

  Future<bool> addFavItem(Item item) async {
    final response = await sqliteDbc.query<int>(
      sql:
          "INSERT OR REPLACE INTO FAV_ITEMS (ID, NAME, VENDOR, RATING, IMAGE_PATH) VALUES (?, ?, ?, ?, ?)",
      values: [item.id, item.name, item.vendor, item.rating, item.imagePath],
    );

    if (response > 0) {
      return true;
    }
    return false;
  }

  Future<bool> removeFavItem(Item item) async {
    final response = await sqliteDbc.query(
      sql: "DELETE FROM FAV_ITEMS WHERE ID = ?",
      values: [item.id],
    );

    if (response > 0) {
      return true;
    }
    return false;
  }
}
