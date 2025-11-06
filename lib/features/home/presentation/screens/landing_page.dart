import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:almasah_dates/features/home/presentation/providers/home_provider.dart';
import 'package:almasah_dates/features/home/presentation/screens/floating_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  final Function(int,[Customer?]) onMenuSelect;
  const LandingPage({super.key, required this.onMenuSelect});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeProvider>().loadHomes());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildSummaryCards(provider, size),
              ),
            const SizedBox(height: 40),
            _buildMenuGrid(context, size),
          ],
        ),
      ),
      floatingActionButton: DropUpFabMenu(onMenuSelect: widget.onMenuSelect),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  // 📊 Dashboard summary cards
  Widget _buildSummaryCards(HomeProvider provider, Size size) {
    final double cardWidth = size.width * 0.4;

    return Wrap(
      spacing: 12,
      runSpacing: 12,      
      alignment: WrapAlignment.center,
      children: [
        _summaryCard(
          title: 'مبلغ الدين',
          value: '${(provider.home.sumPORemain * 100).round() / 100} JOD',
          icon: Icons.money_off,
          color: Colors.redAccent,
          width: cardWidth,
        ),
        _summaryCard(
          title: 'مبلغ الإحمالي',
          value: '${(provider.home.sumSO * 100).round() / 100} JOD',
          icon: Icons.attach_money,
          color: Colors.green,
          width: cardWidth,
        ),
        _summaryCard(
          title: 'المستودع',
          value: '${provider.home.sumPO}',
          icon: Icons.store,
          color: Colors.orangeAccent,
          width: cardWidth,
        ),
      ],
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // 🧭 Menu grid
  Widget _buildMenuGrid(BuildContext context, Size size) {
    final items = [
      {'title': 'المبيعات', 'icon': Icons.point_of_sale, 'index': 6},
      {'title': 'الزبائن', 'icon': Icons.people, 'index': 8},
      {'title': 'الأصناف', 'icon': Icons.category, 'index': 1},
      {'title': 'المشتريات', 'icon': Icons.shopping_cart_outlined, 'index': 5},
      {'title': 'الموردين', 'icon': Icons.store, 'index': 4},
      {'title': 'التقارير', 'icon': Icons.bar_chart, 'index': 7},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (_, i) {
        final item = items[i];
        return _menuButton(
          title: item['title'] as String,
          icon: item['icon'] as IconData,
          onTap: () => widget.onMenuSelect(item['index'] as int),
        );
      },
    );
  }

  Widget _menuButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.teal, size: 40),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}