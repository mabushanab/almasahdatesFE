import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final _itemName = TextEditingController();
  final _itemType = TextEditingController();
  final _itemSubType = TextEditingController();
  final _itemDescr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _salePrice = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ItemProvider>().loadItems());
  }

  Future<void> _refresh() async => context.read<ItemProvider>().loadItems();

  Future<void> _updatePrice(String name, double price) async =>
      context.read<ItemProvider>().updatePrice(name, price);

  Future<double> _getPrice(String name) async {
    return context.read<ItemProvider>().getPrice(name);
  }

  Future<void> _addItem(Item item) async =>
      context.read<ItemProvider>().addItem(item);

  Future<void> _delete(Item item) async =>
      context.read<ItemProvider>().deleteItem(item);

  Future<void> _showAddDialog() async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Item'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _field(_itemName, 'Name', requiredField: true),
                _field(_itemType, 'Type', requiredField: true),
                _field(_itemSubType, 'SubType', requiredField: false),
                _field(_itemDescr, 'Description'),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _addItem(
                  Item(
                    name: _itemName.text,
                    type: _itemType.text,
                    subType: _itemSubType.text,
                    salePrice: double.parse(_salePrice.text),
                  ),
                );
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.check),
            label: const Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String label, {
    bool requiredField = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: requiredField
            ? (v) => v == null || v.trim().isEmpty ? "$label is required" : null
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ItemProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _showAddDialog, icon: const Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          itemCount: provider.items.length,
          itemBuilder: (_, i) {
            final item = provider.items[i];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(item.type),
                trailing: SizedBox(
                  width: 100,
                  height: 40,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.price_change_rounded,
                          color: Color.fromARGB(255, 45, 128, 13),
                        ),
                        onPressed: () async {
                            _salePrice.text = (await _getPrice(item.name)).toString();
                            showDialog(
                              context: context,
                              builder: (context) => StatefulBuilder(
                                builder: (context, setState) => AlertDialog(
                                  title: Text(item.name),
                                  content: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey1,
                                      child: _field(
                                        _salePrice,
                                        'Price',
                                        requiredField: true,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _updatePrice(
                                          item.name,
                                          double.parse(_salePrice.text),
                                        );
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: const Text('Update'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => _delete(item),
                      ),
                    ],
                  ),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(item.name),
                    content: Text('Type: ${item.type}'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
