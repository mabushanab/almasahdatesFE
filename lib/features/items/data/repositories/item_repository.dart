// repositories/item_repository.dart
import 'package:almasah_dates/features/items/data/services/items_service.dart';

import '../models/item.dart';

class ItemRepository {
  final ItemService _service = ItemService();

  Future<List<Item>> getItems() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchItems();
  }

  Future<void> addItem(Item item) async {

    return await _service.addItem(item);
  }


  Future<void> deleteItem(String name) async {
    return await _service.deleteItem(name);

  }

  Future<void> updatePrice(String name, double price) async {
    return await _service.updatePrice(name,price);
  }

}
