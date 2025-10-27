import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/home/presentation/screens/generator_page.dart';
import 'package:almasah_dates/features/home/presentation/screens/landing_page.dart';
import 'package:almasah_dates/features/items/presentation/screens/item_list_screen.dart';
import 'package:almasah_dates/features/marchent/presentation/screens/merchant_list_screen.dart';
import 'package:almasah_dates/features/purchaseOrder/presentation/screens/purchaseOrder_screen.dart';
import 'package:almasah_dates/features/saleOrder/presentation/screens/saleOrder_screen.dart';
import 'package:flutter/material.dart';

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var navIndex = 2;
  int pageIndex = 2;

  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    pages.addAll([
      GeneratorPage(onMenuSelect: goToPage),
      ItemListScreen(),
      LandingPage(onMenuSelect: goToPage),
      MerchantListScreen(),
      PurchaseOrderListScreen(),
      SaleOrderListScreen(),
    ]);
  }

  Future<void> _logout() async {
    final success = await _authService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  final List<Widget> pages = [];

  final List<NavigationDestination> navDestinations = [
    NavigationDestination(icon: Icon(Icons.menu), label: 'Menue'),
    NavigationDestination(icon: Icon(Icons.category), label: 'items'),
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.add), label: 'Add +'),
    NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
  ];

  final List<int?> navToPage = [0, 1, 2, 3, null];

  void _onNavTap(int tappedNavIndex) {
    if (tappedNavIndex == 0) {
      _scaffoldKey.currentState?.openDrawer();
      return;
    } else if (tappedNavIndex == 4) {
      _logout();
      return;
    }
    setState(() {
      navIndex = tappedNavIndex;
      pageIndex = navToPage[tappedNavIndex]!;
    });
  }

  void goToPage(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
      final navMatch = navToPage.indexOf(newPageIndex);
      if (navMatch != -1) navIndex = navMatch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      drawer: GeneratorPage(
        onMenuSelect: (index) {
           Navigator.pop(context);
          goToPage(index);
        },
      ),
      body: pages[pageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        onDestinationSelected: _onNavTap,
        destinations: navDestinations,
      ),
    );
  }
}
