import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:almasah_dates/features/saleOrder/presentation/providers/saleOrder_providerPerCustomer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  final Customer selectedCustomer;
  final Function(int, [Customer?]) onMenuSelect;

  const CustomerScreen({
    super.key,
    required this.selectedCustomer,
    required this.onMenuSelect,
  });

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SaleOrderProviderPerCustomer>().loadSaleOrdersForCustomer(
            widget.selectedCustomer.name,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SaleOrderProviderPerCustomer>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedCustomer.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Customer Summary Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _InfoTile(
                      icon: Icons.payments_rounded,
                      label: "Total",
                      value: provider.total.toString(),
                      color: Colors.green.shade700,
                    ),
                    _InfoTile(
                      icon: Icons.account_balance_wallet_rounded,
                      label: "Remain",
                      value: provider.remain.toString(),
                      color: Colors.orange.shade700,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Button Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  widget.onMenuSelect(10, widget.selectedCustomer);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_forward_ios, color: Colors.teal),
                      SizedBox(width: 8),
                      Text(
                        'View Sale Orders',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Optional: Sale orders list (if loaded)
            if (provider.saleOrders.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: provider.saleOrders.length,
                  itemBuilder: (context, index) {
                    final order = provider.saleOrders[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(
                          'Order #${order.sOId ?? ''}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Date: ${order.date}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        trailing: Text(
                          '${order.totalPrice} JD',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (provider.saleOrders.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Text(
                  'No sale orders found for this customer.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
