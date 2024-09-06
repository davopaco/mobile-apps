import 'package:items_list/model/item.dart';
import 'package:items_list/services/items_service.dart';

class ItemsUseCase {
  final ItemsService _itemsService;

  ItemsUseCase({required ItemsService itemsService})
      : _itemsService = itemsService;

  Future<List<Item>> getItems() async {
    return await _itemsService.getItems();
  }

  Future<List<Item>> getFavoriteItems() async {
    return await _itemsService.getFavItems();
  }

  Future<bool> addFavoriteItem(Item item) async {
    return await _itemsService.addFavItem(item);
  }

  Future<bool> removeFavoriteItem(Item item) async {
    return await _itemsService.removeFavItem(item);
  }

  Future<bool> isFavoriteItem(Item item) async {
    return await _itemsService.isFavItem(item);
  }
}
