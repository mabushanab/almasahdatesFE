import 'package:almasah_dates/features/items/data/services/items_service.dart';
import 'package:almasah_dates/main.dart';
import 'package:almasah_dates/shared/big_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
  final _items_service = ItemService();
  // List items =;
  Future<void> _refresh() async {

    _items_service.fetchItems();

    }
    IconData icon;
    if (appState.fav.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            ElevatedButton(
              onPressed: _refresh,
              child: Text('Refresh'),
            ),
              ElevatedButton.icon(
                onPressed: () {
                  appState.togglefavs();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getnext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}