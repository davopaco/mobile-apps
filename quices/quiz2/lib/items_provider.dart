import 'dart:convert';
import 'package:quiz2/model/item.dart';
import 'package:http/http.dart' as http;

class ItemsProvider {
  static Future<List<Item>> getAllItems() async {
    var response =
        await http.get(Uri.parse("https://api.npoint.io/88abc1f40845fe530fd4"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> itemsJson = json.decode(response.body);
      List<Item> items = [];
      for (Map<String, dynamic> item in itemsJson['articulos']) {
        items.add(Item.fromJson(item));
      }
      return items;
    } else {
      throw Exception("Error al cargar los datos");
    }
  }

  static Future<List<Item>> getDiscountItems() async {
    List<Item> allItems = await getAllItems();
    return allItems.where((item) => item.discount > 0).toList();
  }
}
