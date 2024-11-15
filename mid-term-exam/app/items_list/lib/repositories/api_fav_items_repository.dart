import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:items_list/model/item.dart';
import 'package:items_list/repositories/login_repository.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class APIFavItemsRepository {
  final LoginRepository loginRepository;
  final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
  final port = dotenv.env['PORT'] ?? '3000';

  APIFavItemsRepository({required this.loginRepository});

  Future<List<Item>> getFavItems() async {
    final token = await loginRepository.getToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final response =
        await http.get(Uri.parse("$host:$port/favorite/all"), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> itemsJson = json.decode(response.body);
      if (itemsJson["favorite"].length == 0) {
        return [];
      }
      List<Item> items = [];
      itemsJson["favorite"].forEach((json) => {items.add(Item.fromJson(json))});
      return items;
    } else {
      return [];
    }
  }

  Future<bool> addFavItem(Item item) async {
    final token = await loginRepository.getToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final json = item.toJson();
    final body = jsonEncode({
      "item_id": json["id"],
    });

    final response = await http.post(
      Uri.parse("$host:$port/favorite/add"),
      headers: headers,
      body: body,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }
    return false;
  }

  Future<bool> removeFavItem(Item item) async {
    final token = await loginRepository.getToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final json = item.toJson();
    final body = jsonEncode({
      "item_id": json["id"],
    });

    final response = await http.post(
      Uri.parse("$host:$port/favorite/remove"),
      headers: headers,
      body: body,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }
    return false;
  }
}
