// screens/item_list_screen.dart
import 'package:almasah_dates/features/items/data/services/items_service.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListScreen extends StatefulWidget {
   ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final _items_service = ItemService();

  @override
  void initState() {
    super.initState();

    // ✅ Load items once when the screen opens
    Future.microtask(() =>
        context.read<ItemProvider>().loadItems());
  }

  // List items =;
  Future<void> _refresh() async {

    _items_service.fetchItems();

    }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ItemProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.items.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(provider.items[i].name),
              ),
            )
            ,
    );
  }
}
