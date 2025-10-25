import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/home/presentation/screens/favs.dart';
import 'package:almasah_dates/features/home/presentation/screens/generator_page.dart';
import 'package:almasah_dates/features/items/presentation/screens/item_list_screen.dart';
import 'package:almasah_dates/features/marchent/presentation/screens/merchant_list_screen.dart';
import 'package:almasah_dates/features/purchaseOrder/presentation/screens/purchaseOrder_screen.dart';
import 'package:flutter/material.dart';

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedIndex = 1;
  final _authService = AuthService();

  Future<void> _logout() async {
    final success = await _authService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 1:
        page = favs();
        print('1');
        break;
      case 2:
        page = ItemListScreen();
        print('2');
        break;
      case 3:
        page = MerchantListScreen();
        print('3');
        break;
      case 4:
        page = PurchaseOrderListScreen();
        print('4');
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return _navigationBar(context, page);
  }

  Scaffold _navigationRail(BuildContext context, Widget page) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            // bottom: true,
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.category),
                  label: Text('items'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people),
                  label: Text('Customers'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_pin),
                  label: Text('Marchents'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              trailing: IconButton(
                onPressed: _logout,
                icon: Icon(Icons.logout),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Favorites Page')),
    Center(child: Text('Items Page')),
    Center(child: Text('Customers Page')),
    Center(child: Text('Merchants Page')),
  ];

  Scaffold _navigationBar(BuildContext context, Widget page) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: GeneratorPage(
        onMenuSelect: (index) {
          setState(() => selectedIndex = index);
        },
      ),
      body: page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          if (index == 0) {
            _scaffoldKey.currentState?.openDrawer();
            return;
          }
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.menu), label: 'Menue'),
          NavigationDestination(icon: Icon(Icons.category), label: 'items'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Add +'),
          IconButton(onPressed: _logout, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
