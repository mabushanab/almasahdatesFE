import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:flutter/material.dart';

class GeneratorPage extends StatelessWidget {
  final Function(int) onMenuSelect;
  GeneratorPage({required this.onMenuSelect, super.key});

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF9E3110),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _drawerItem(Icons.home, 'Home', () => onMenuSelect(2)),
                _drawerItem(Icons.people, 'Customers', () => onMenuSelect(3)),
                _drawerItem(Icons.store, 'Merchants', () => onMenuSelect(4)),
                _drawerItem(Icons.shopping_cart, 'Purchase Orders', () => onMenuSelect(5)),
                _drawerItem(Icons.sell, 'Sale Orders', () => onMenuSelect(6)),
                const Divider(thickness: 1),
                _drawerItem(Icons.logout, 'Logout', () {
                  _authService.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF9E3110)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
