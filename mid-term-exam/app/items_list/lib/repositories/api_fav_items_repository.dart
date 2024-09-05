import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:items_list/model/item.dart';

class APIFavItemsRepository {
  Future<List<Item>> getFavItems() async {
    final response =
        await http.get(Uri.parse("http://localhost:3000/favorite/all"));
    if (response.statusCode == 200) {
      final List<dynamic> itemsJson = json.decode(response.body);
      return itemsJson.map((json) => Item.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<bool> addFavItem(Item item) async {
    final response = await http.post(
      Uri.parse("http://localhost:3000/favorite/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }
    return false;
  }

  Future<bool> removeFavItem(Item item) async {
    final response = await http.post(
      Uri.parse("http://localhost:3000/favorite/remove"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }
    return false;
  }
}
