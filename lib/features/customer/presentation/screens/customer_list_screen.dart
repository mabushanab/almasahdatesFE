import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:almasah_dates/features/customer/presentation/providers/customer_provider.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final _formKey = GlobalKey<FormState>();

  final _customerName = TextEditingController();
  final _customerType = TextEditingController();
  final _customerAddress = TextEditingController();
  final _customerMobileNumber = TextEditingController();
  final _customerNotes = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CustomerProvider>().loadCustomers());
  }

  bool _isFormValid() => _formKey.currentState!.validate();

  Future<void> _refresh() async =>
      context.read<CustomerProvider>().loadCustomers();

  Future<void> _addCustomer(Customer customer) async =>
      context.read<CustomerProvider>().addCustomer(customer);

  Future<void> _deleteCustomer(Customer customer) async =>
      context.read<CustomerProvider>().deleteCustomer(customer);

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Customer', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                _buildTextField(_customerName, 'Name', validator: true),
                _buildTextField(_customerType, 'Type', validator: true),
                _buildTextField(_customerMobileNumber, 'Mobile Number'),
                _buildTextField(_customerAddress, 'Address', validator: true),
                _buildTextField(_customerNotes, 'Notes'),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add'),
            onPressed: () {
              if (_isFormValid()) {
                _addCustomer(Customer(
                  name: _customerName.text,
                  type: _customerType.text,
                  address: _customerAddress.text,
                  mobileNumber: _customerMobileNumber.text,
                  notes: _customerNotes.text,
                ));
                Navigator.pop(context);
              }
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool validator = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        validator: validator
            ? (value) => (value == null || value.trim().isEmpty) ? '$label is required' : null
            : null,
      ),
    );
  }

  void _showCustomerDetails(Customer c) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Customer Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow('Name', c.name),
            _detailRow('Type', c.type),
            _detailRow('Mobile', c.mobileNumber),
            _detailRow('Address', c.address),
            _detailRow('Notes', c.notes),
            _detailRow('Rate', '${c.rate ?? '-'}'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Widget _detailRow(String title, String? value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text('$title: ${value ?? ''}', style: const TextStyle(fontSize: 14)),
      );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _showAddCustomerDialog, icon: const Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: provider.customers.length,
          itemBuilder: (_, i) {
            final c = provider.customers[i];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ListTile(
                title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(c.type),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteCustomer(c),
                ),
                onTap: () => _showCustomerDetails(c),
              ),
            );
          },
        ),
      ),
    );
  }
}
