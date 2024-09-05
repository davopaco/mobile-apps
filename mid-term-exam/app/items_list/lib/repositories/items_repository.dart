import "dart:convert";
import "package:http/http.dart" as http;
import "package:items_list/model/item.dart";

class ItemsRepository {
  Future<List<Item>> getItems() async {
    final response =
        await http.get(Uri.parse("http://localhost:3000/item/all"));
    if (response.statusCode == 200) {
      final List<dynamic> itemsJson = json.decode(response.body);
      return itemsJson.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
