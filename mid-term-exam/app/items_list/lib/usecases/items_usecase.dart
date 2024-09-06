import 'package:items_list/model/item.dart';
import 'package:items_list/services/items_service.dart';

class ItemsUseCase {
  final ItemsService _itemsService;

  ItemsUseCase({required ItemsService itemsService})
      : _itemsService = itemsService;

  Future<List<Item>> getItems() async {
    return await _itemsService.getItems();
  }
}
