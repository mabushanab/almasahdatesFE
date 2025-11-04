import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:almasah_dates/features/auth/presentation/widgets/password_widget.dart';
import 'package:almasah_dates/features/customer/presentation/screens/customer_list_screen.dart';
import 'package:almasah_dates/features/home/presentation/screens/generator_page.dart';
import 'package:almasah_dates/features/home/presentation/screens/landing_page.dart';
import 'package:almasah_dates/features/items/presentation/screens/item_list_screen.dart';
import 'package:almasah_dates/features/marchent/presentation/screens/merchant_list_screen.dart';
import 'package:almasah_dates/features/purchaseOrder/presentation/screens/purchaseOrder_screen.dart';
import 'package:almasah_dates/features/reports/presentation/screens/report_page.dart';
import 'package:almasah_dates/features/saleOrder/presentation/screens/saleOrder_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _authService = AuthService();

  int navIndex = 2; // NavigationBar selected index
  int pageIndex = 2; // Page being displayed
  final List<Widget> pages = [];

  final List<NavigationDestination> navDestinations = const [
    NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
    NavigationDestination(icon: Icon(Icons.category_outlined), label: 'Items'),
    NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.add_circle_outline), label: 'Add +'),
    NavigationDestination(icon: Icon(Icons.logout_outlined), label: 'Logout'),
  ];

  /// Map NavigationBar index -> pages list index (null = no page)
  final List<int?> navToPage = [0, 1, 2, 3, null];

  @override
  void initState() {
    super.initState();
    pages.addAll([
      GeneratorPage(onMenuSelect: goToPage), // 0
      const ItemListScreen(), // 1
      LandingPage(onMenuSelect: goToPage), // 2
      Center(
        child: _showDialog(
          options: ['Option 1', 'Option 2', 'Option 3'],
          onSelected: (d) {
            print('Selected: $d');
          },
        ),
      ),
      const MerchantListScreen(), // 4
      const PurchaseOrderListScreen(), // 5 (protected)
      const SaleOrderListScreen(), // 6
      const ReportPage(), // 7 (protected)
      const CustomerListScreen(), // 8
    ]);
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> _onNavTap(int tappedIndex) async {
    // Drawer
    if (tappedIndex == 0) {
      _scaffoldKey.currentState?.openDrawer();
      return;
    }

    // Logout
    if (tappedIndex == 4) {
      _logout();
      return;
    }

    // Default pageIndex mapping
    int? targetPage = navToPage[tappedIndex];

    // If page is protected (PurchaseOrder = 5, SaleOrder = 6)
    if (targetPage == 5 || targetPage == 7) {
      bool accessGranted = await showPasswordDialog(context);
      if (!accessGranted) return;
      pageIndex = targetPage!; // show the protected page
      setState(() {
        navIndex = tappedIndex;
      });
      return;
    }

    // Normal page
    if (targetPage != null) {
      setState(() {
        navIndex = tappedIndex;
        pageIndex = targetPage;
      });
    }
  }

  void goToPage(int newPageIndex) async {
    // Protect PurchaseOrder and SaleOrder pages
    if (newPageIndex == 5 || newPageIndex == 7) {
      bool accessGranted = await showPasswordDialog(context);
      if (!accessGranted) return;
    }

    setState(() {
      pageIndex = newPageIndex;
      // Update navIndex if page is linked to NavigationBar
      int navMatch = navToPage.indexOf(newPageIndex);
      if (navMatch != -1) navIndex = navMatch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: GeneratorPage(
        onMenuSelect: (index) {
          Navigator.pop(context);
          goToPage(index);
        },
      ),
      body: SafeArea(child: pages[pageIndex]),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.brown.withOpacity(0.2),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 13),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navIndex,
          onDestinationSelected: _onNavTap,
          destinations: navDestinations,
          elevation: 4,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _showDialog({
    required List<String> options,
    required void Function(String) onSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8), // space above button
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black26, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options
            .map(
              (opt) => InkWell(
                onTap: () => onSelected(opt),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(opt, style: const TextStyle(fontSize: 16)),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
