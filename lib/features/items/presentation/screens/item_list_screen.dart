// screens/item_list_screen.dart
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
  final _itemdescr = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Key to access the Form

  @override
  void initState() {
    super.initState();

    // ✅ Load items once when the screen opens
    Future.microtask(() => context.read<ItemProvider>().loadItems());
  }

  bool _validateAddingItem() {
    return (_formKey.currentState!.validate());
  }

  // List items =;
  Future<void> _refresh() async {
    await context.read<ItemProvider>().loadItems();
  }

  Future<void> _addItem(Item item) async {
    await context.read<ItemProvider>().addItem(item);
  }

  Future<void> _delete(Item item) async {
    await context.read<ItemProvider>().deleteItem(item);
  }

  Future<dynamic> _addItemDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add item'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400, // prevent infinite height
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _itemName,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name is required";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _itemType,
                    decoration: const InputDecoration(labelText: 'Type'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Type is required";
                      }
                    },
                  ),
                  TextField(
                    controller: _itemSubType,
                    decoration: const InputDecoration(labelText: 'SubType'),
                  ),
                  TextField(
                    controller: _itemdescr,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
            ),
          ),
        ),

        actions: [
          ElevatedButton(
            onPressed: () {
              if (_validateAddingItem()) {
                _addItem(Item(name: _itemName.text, type: _itemType.text));
                Navigator.pop(context);
              }
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

  Future<dynamic> _showItemDialog(Item item) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Show item'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400, // prevent infinite height
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: ' + item.name),
                Text('Type: ' + item.type),
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
    final provider = context.watch<ItemProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Items', style: TextStyle()),
            Spacer(),
            IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
            IconButton(
              onPressed: () {
                _addItemDialog(context);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: provider.items.length,
        itemBuilder: (_, i) => TextButton(
          onPressed: () => _showItemDialog(provider.items[i]),

          // context);
          // onPressed: () {
          // _showItemDialog(provider.items[i],
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
                Text(provider.items[i].name),
                const Spacer(),
                IconButton(
                  onPressed: () => _delete(provider.items[i]),
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
