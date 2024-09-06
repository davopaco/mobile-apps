import 'package:items_list/repositories/api_fav_items_repository.dart';
import 'package:items_list/repositories/fav_items_repository.dart';
import 'package:items_list/repositories/items_repository.dart';
import 'package:items_list/model/item.dart';

class ItemsService {
  final APIFavItemsRepository apiFavItemsRepository;
  final FavItemsRepository favItemsRepository;
  final ItemsRepository itemsRepository;

  ItemsService._(
      {required this.apiFavItemsRepository,
      required this.favItemsRepository,
      required this.itemsRepository});

  static Future<ItemsService> createInstance(
      APIFavItemsRepository apiFavItemsRepository,
      FavItemsRepository favItemsRepository,
      ItemsRepository itemsRepository) async {
    var instance = ItemsService._(
        apiFavItemsRepository: apiFavItemsRepository,
        favItemsRepository: favItemsRepository,
        itemsRepository: itemsRepository);
    await instance._init();
    return instance;
  }

  Future<void> _init() async {
    final items = await apiFavItemsRepository.getFavItems();
    items.forEach((item) async {
      await favItemsRepository.addFavItem(item);
    });
  }

  Future<List<Item>> getItems() async {
    return await itemsRepository.getItems();
  }

  Future<bool> addFavItem(Item item) async {
    final apiResult = await apiFavItemsRepository.addFavItem(item);
    final apiResult2 = await favItemsRepository.addFavItem(item);
    return apiResult && apiResult2;
  }

  Future<bool> removeFavItem(Item item) async {
    final apiResult = await apiFavItemsRepository.removeFavItem(item);
    final apiResult2 = await favItemsRepository.removeFavItem(item);
    return apiResult && apiResult2;
  }

  Future<List<Item>> getFavItems() async {
    return await favItemsRepository.getFavItems();
  }

  Future<bool> isFavItem(Item item) async {
    final favItems = await favItemsRepository.getFavItems();
    return favItems.contains(item);
  }
}
