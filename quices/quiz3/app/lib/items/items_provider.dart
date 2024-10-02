import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quiz3/login/login_serv.dart';
import 'package:quiz3/model/item.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ItemsProvider {
  static LoginService _loginService = LoginService();

  static Future<List<Item>> _itemsRequest(String api_url) async {
    var response = await http.get(Uri.parse(api_url));
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

  static Future<Map<String, String>> _getHeaders() async {
    Map<String, dynamic> tokenMap = await _loginService.getLoginToken();
    if (!tokenMap['error']) {
      _loginService.logout();
      Get.offAllNamed("/login");
    }

    String token = tokenMap['token'];

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
  }

  static Future<List<Item>> getDiscountItems() async {
    String api_url = dotenv.env['API_URL'] ?? "" + '/items/sale';
    return _itemsRequest(api_url);
  }

  static Future<List<Item>> getAllItems() async {
    String api_url = dotenv.env['API_URL'] ?? "" + '/items/all';
    return _itemsRequest(api_url);
  }
}
