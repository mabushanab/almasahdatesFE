// widgets/item_tile.dart
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      // subtitle: Text('${item.price} JOD'),
    );
  }
}
