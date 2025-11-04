import 'package:almasah_dates/features/auth/data/services/auth_service.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _authService = AuthService();

  int navIndex = 2; // NavigationBar selected index
  int pageIndex = 2; // Page being displayed
  final List<Widget> pages = [];

  final List<NavigationDestination> navDestinations = const [
    NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
    NavigationDestination(icon: Icon(Icons.category_outlined), label: 'Items'),
    // NavigationDestination(icon: Icon(Icons.report_filled), label: 'Report'),
    NavigationDestination(icon: Icon(Icons.add_circle_outline), label: 'Add +'),
    NavigationDestination(icon: Icon(Icons.logout_outlined), label: 'Logout'),
  ];

  /// Map NavigationBar index -> pages list index (null = no page)
  final List<int?> navToPage = [0, 1, 2, 3, null];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
        actions: [
          // IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
