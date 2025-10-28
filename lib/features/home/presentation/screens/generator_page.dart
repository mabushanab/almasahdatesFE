import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  final Function(int) onMenuSelect;
  GeneratorPage({required this.onMenuSelect, super.key});

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    context.watch<MyAppState>();
    return _menue(context);
  }

  Drawer _menue(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
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
              _authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
