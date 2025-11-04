import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';

class ItemAddDialog extends StatefulWidget {
  const ItemAddDialog({super.key});

  @override
  State<ItemAddDialog> createState() => _ItemAddDialogState();
}

class _ItemAddDialogState extends State<ItemAddDialog> {
  final _formKey = GlobalKey<FormState>();
  final _itemName = TextEditingController();
  final _itemType = TextEditingController();
  final _itemSubType = TextEditingController();
  final _itemDescr = TextEditingController();
  final _salePrice = TextEditingController();

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<ItemProvider>();

      await provider.addItem(
        Item(
          name: _itemName.text,
          type: _itemType.text,
          subType: _itemSubType.text,
          salePrice: double.tryParse(_salePrice.text) ?? 0.0,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Item'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              field(_itemName, 'Name', requiredField: true),
              field(_itemType, 'Type', requiredField: true),
              field(_itemSubType, 'SubType'),
              field(_itemDescr, 'Description'),
              field(_salePrice, 'Sale Price', requiredField: true),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: _handleSubmit,
          icon: const Icon(Icons.check),
          label: const Text('Add'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

  Widget field(TextEditingController c, String label,
      {bool requiredField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: requiredField
            ? (v) => (v == null || v.trim().isEmpty)
                ? "$label is required"
                : null
            : null,
      ),
    );
  }