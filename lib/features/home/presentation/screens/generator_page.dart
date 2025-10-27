import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/items/data/services/items_service.dart';
import 'package:almasah_dates/main.dart';
import 'package:almasah_dates/shared/big_card.dart';
import 'package:english_words/src/word_pair.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  final Function(int) onMenuSelect;
  GeneratorPage({required this.onMenuSelect, super.key});

  final _authService = AuthService();

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
    return _menue(context);
  }

  Center _menueT(
    WordPair pair,
    Future<void> Function() _refresh,
    MyAppState appState,
    IconData icon,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: _refresh, child: Text('Refresh')),
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

  Drawer _menue(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height:
                MediaQuery.of(context).size.height * 0.1,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 158, 49, 16),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              onMenuSelect(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Customers'),
            onTap: () {
              onMenuSelect(3);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Merchants'),
            onTap: () {
              onMenuSelect(4);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Perchase Orders'),
            onTap: () {
              onMenuSelect(5);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Sale Orders'),
            onTap: () {
              onMenuSelect(6);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              final success = _authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
