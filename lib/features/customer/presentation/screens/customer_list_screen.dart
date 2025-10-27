// screens/customer_list_screen.dart
import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:almasah_dates/features/customer/presentation/providers/customer_provider.dart';
import 'package:almasah_dates/features/marchent/data/models/merchent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final _customerName = TextEditingController();
  final _customerType = TextEditingController();
  final _customerAddress = TextEditingController();
  final _customerMobileNumber = TextEditingController();
  final _customerNotes = TextEditingController();
  // final _customerRate = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ Load customers once when the screen opens
    Future.microtask(() => context.read<CustomerProvider>().loadCustomers());
  }

  // List customers =;
  Future<void> _refresh() async {
    await context.read<CustomerProvider>().loadCustomers();
  }

  Future<void> _addCustomer(Customer customer) async {
    await context.read<CustomerProvider>().addCustomer(customer);
  }

  Future<void> _delete(Customer customer) async {
    await context.read<CustomerProvider>().deleteCustomer(customer);
  }

  Future<dynamic> _addCustomerDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add customer'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400, // prevent infinite height
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _customerName,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _customerType,
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                TextField(
                  controller: _customerMobileNumber,
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                ),
                TextField(
                  controller: _customerAddress,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                                TextField(
                  controller: _customerNotes,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
        ),

        actions: [
          ElevatedButton(
            onPressed: () {
              _addCustomer(Customer(name: _customerName.text, type: _customerType.text,address: _customerAddress.text, mobileNumber: _customerMobileNumber.text,notes: _customerNotes.text));
              Navigator.pop(context); // close popup
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context), // close dialog
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showCustomerDialog(Customer customer) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Show customer'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400, // prevent infinite height
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: ${customer.name}'),
                Text('Type: ${customer.type}'),
                Text('Mobile: ${customer.mobileNumber}'),
                Text('Addr: ${customer.address}'),
                Text('Notes: ${customer.notes}'),
                Text('Rate: ${customer.rate}'),
                ],
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // close dialog
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Customers', style: TextStyle()),
            Spacer(),
            IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
            IconButton(
              onPressed: () {
                _addCustomerDialog(context);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: provider.customers.length,
        itemBuilder: (_, i) => TextButton(
          onPressed: () => _showCustomerDialog(provider.customers[i]),

          // context);
          // onPressed: () {
          // _showCustomerDialog(provider.customers[i],
          // },
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(provider.customers[i].name),
                const Spacer(),
                IconButton(
                  onPressed: () => _delete(provider.customers[i]),
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
