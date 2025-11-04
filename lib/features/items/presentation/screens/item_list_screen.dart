import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:almasah_dates/features/items/presentation/screens/ItemAddDialog.dart';
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
    builder: (_) => ItemAddDialog(),
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
                                      child: field(
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
