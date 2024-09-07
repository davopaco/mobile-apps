import "dart:convert";
import "package:http/http.dart" as http;
import "package:items_list/model/item.dart";
import "package:items_list/repositories/login_repository.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

class ItemsRepository {
  final LoginRepository loginRepository;
  final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
  final port = dotenv.env['PORT'] ?? '3000';

  ItemsRepository({required this.loginRepository});

  Future<List<Item>> getItems() async {
    final token = await loginRepository.getToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final response =
        await http.get(Uri.parse("$host:$port/item/all"), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> itemsJson = json.decode(response.body);
      if (itemsJson["items"].length == 0) {
        return [];
      }
      List<Item> items = [];
      itemsJson["items"].forEach((json) => {items.add(Item.fromJson(json))});
      return items;
    } else {
      try {
        throw Exception('Failed to load items');
      } catch (e) {
        print(e);
        return [];
      }
    }
  }
}
