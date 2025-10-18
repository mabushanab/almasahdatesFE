// screens/item_list_screen.dart
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

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
            ),
    );
  }
}
