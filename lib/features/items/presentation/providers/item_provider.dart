// providers/item_provider.dart
import 'package:flutter/foundation.dart';
import '../../data/models/item.dart';
import '../../data/repositories/item_repository.dart';

class ItemProvider extends ChangeNotifier {
  final ItemRepository _repo = ItemRepository();
  List<Item> items = [];
  bool isLoading = false;

  Future<void> loadItems() async {
    isLoading = true;
    notifyListeners();

    items = await _repo.getItems();

    isLoading = false;
    notifyListeners();
  }
}