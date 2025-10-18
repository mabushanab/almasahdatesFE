import 'package:almasah_dates/features/items/data/services/items_service.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  final _items_service = ItemService();
  // List items =;
  Future<void> _refresh() async {

    _items_service.fetchItems();

    }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _refresh,
              child: Text('Refresh'),
            ),
            Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Login Page', style: style),
              ),
            ),
          ],
        ),
      ),
    );
  }
}