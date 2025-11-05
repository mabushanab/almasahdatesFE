import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:almasah_dates/features/customer/presentation/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saleorderadddialog extends StatefulWidget {
  @override
  State<Saleorderadddialog> createState() => _Saleorderadddialog();
  final Function(int, [Customer?]) onMenuSelect;
  const Saleorderadddialog({super.key, required this.onMenuSelect});
}

class _Saleorderadddialog extends State<Saleorderadddialog> {
  Customer? selectedCustomer;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CustomerProvider>().loadCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = context.read<CustomerProvider>();
    return AlertDialog(
      title: const Text('Add Sale Order'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              DropdownButtonFormField<Customer>(
                decoration: const InputDecoration(labelText: 'Customer Name'),
                value: selectedCustomer,
                items: customerProvider.customers
                    .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                    .toList(),
                onChanged: (c) => setState(() => selectedCustomer = c),
                validator: (v) => v == null ? "Customer is required" : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton.icon(
          icon: const Icon(Icons.keyboard_double_arrow_left_outlined),
          label: const Text('Go'),
          onPressed: () {
            // CustomerProvider cu

            widget.onMenuSelect(10, selectedCustomer);
            print(selectedCustomer!.name);
            Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
