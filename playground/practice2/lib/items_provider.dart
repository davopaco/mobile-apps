import 'dart:convert';

import 'package:practice2/model/Item.dart';
import "package:http/http.dart" as http;

class ItemsProvider {
  static Future<List<Item>> getAllItems() async {
    const apiEndpoint = "https://api.npoint.io/237a0d1ac8530064cc04";

    var response = await http.get(Uri.parse(apiEndpoint));
    if (response.statusCode == 200) {
      final Map<String, dynamic> itemsJson = json.decode(response.body);
      print(itemsJson);
      List<Item> items = [];
      for (var item in itemsJson["articulos"]) {
        items.add(Item.fromJson(item));
      }
      return items;
    } else {
      throw Exception("Failed to load items");
    }
  }

  static Future<List<Item>> getDiscountItems() async {
    List<Item> items = await getAllItems();
    List<Item> discountItems = [];
    for (var item in items) {
      if (item.discount > 0) {
        discountItems.add(item);
      }
    }
    return discountItems;
  }
}
