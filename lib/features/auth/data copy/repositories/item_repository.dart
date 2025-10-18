// repositories/item_repository.dart
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/data/services/items_service.dart';


class ItemRepository {
  final ItemService _service = ItemService();

  Future<List<Item>> getItems() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchItems();
  }
}
