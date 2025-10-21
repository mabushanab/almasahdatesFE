// screens/item_list_screen.dart
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/data/services/items_service.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final _items_service = ItemService();
  final _itemName = TextEditingController();
  final _itemType = TextEditingController();
  final _itemSubType = TextEditingController();
  final _itemdescr = TextEditingController();
  @override
  void initState() {
    super.initState();

    // ✅ Load items once when the screen opens
    Future.microtask(() => context.read<ItemProvider>().loadItems());
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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ItemProvider>();

    return Column(
      children: [
        SizedBox(
          width: 250,
          height: 200,
          child: Scaffold(
            // floatingActionButton: ElevatedButton(onPressed: () => print('object'), child: Text('data')),
            backgroundColor: Colors.cyan,
            appBar: AppBar(
              title: Row(
                children: [
                  const Text('Items'),
                  Spacer(),
                  IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Add item'),
                          content: Column(
                            children: [
                              // const Text('Do you want to delete this item?'),
                              TextField(
                                controller: _itemName,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                ),
                              ),
                              TextField(
                                controller: _itemType,
                                decoration: const InputDecoration(
                                  labelText: 'Type',
                                ),
                              ),
                              TextField(
                                controller: _itemSubType,
                                decoration: const InputDecoration(
                                  labelText: 'SubType',
                                ),
                              ),
                              TextField(
                                controller: _itemdescr,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                ),
                              ),
                            ],
                          ),

                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                _addItem(Item(name: _itemName.text, type: _itemType.text));
                                Navigator.pop(context); // close popup
                              },
                              child: const Text('Add'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context), // close dialog
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),

            body: //provider.isLoading
                // ? const Center(child: CircularProgressIndicator())
                // ignore: sized_box_for_whitespace
                Container(
                  width: 250,
                  height: 200,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,

                    // margin: EdgeInsets.zero,
                    itemCount: provider.items.length,
                    itemBuilder: (_, i) => Card(
                      // margin: EdgeInsets.zero,
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Text(provider.items[i].name),
                          const Spacer(), // p
                          IconButton(
                            onPressed: () => _delete(provider.items[i]),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

            // ),
          ),
        ),
      ],
    );
  }
}
