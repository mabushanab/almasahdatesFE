import 'package:almasah_dates/features/goods/data/models/goods.dart';
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:almasah_dates/features/marchent/data/models/merchent.dart';
import 'package:almasah_dates/features/marchent/presentation/providers/merchant_provider.dart';
import 'package:almasah_dates/features/purchaseOrder/data/models/purchaseOrder.dart';
import 'package:almasah_dates/features/purchaseOrder/presentation/providers/purchaseOrder_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});

  @override
  State<PurchaseOrderListScreen> createState() =>
      _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  final _totalPrice = TextEditingController();
  final _remainAmount = TextEditingController();
  Merchant? selectedMerchant;
  Item? selectedItem;
  List<Widget> goodsWidgets = [];
  List<Goods> goods = [];
  int i = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ItemProvider>().loadItems());

    Future.microtask(() => context.read<MerchantProvider>().loadMerchants());
    Future.microtask(
      () => context.read<PurchaseOrderProvider>().loadPurchaseOrders(),
    );
  }

  Future<void> _refresh() async {
    await context.read<PurchaseOrderProvider>().loadPurchaseOrders();
  }

  Future<void> _addPurchaseOrder(PurchaseOrder purchaseOrder) async {
    await context.read<PurchaseOrderProvider>().addPurchaseOrder(purchaseOrder);
  }

  Future<void> _delete(PurchaseOrder purchaseOrder) async {
    await context.read<PurchaseOrderProvider>().deletePurchaseOrder(
      purchaseOrder,
    );
  }

  Future<String> _removeGood(int i) async {
    goodsWidgets.removeAt(i);
    return "Deleted";
  }

  Future<dynamic> _addPurchaseOrderDialog(
    BuildContext context,
    MerchantProvider merchantProvider,
    ItemProvider itemProvider,
  ) {
    // final itemProvider = context.watch<ItemProvider>();

    goodsWidgets.clear();
    goods.clear();
    selectedMerchant = null;
    _remainAmount.clear();
    _totalPrice.clear();
    i = 0;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add purchaseOrder'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Merchant Name: '),
                      DropdownButton<Merchant>(
                        value: selectedMerchant,
                        items: merchantProvider.merchants
                            .map(
                              (m) => DropdownMenuItem(
                                value: m,
                                child: Text(m.name),
                              ),
                            )
                            .toList(),
                        onChanged: (m) => setState(() => selectedMerchant = m),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _totalPrice,
                    decoration: const InputDecoration(
                      labelText: 'Total Price: ',
                    ),
                  ),
                  TextField(
                    controller: _remainAmount,
                    decoration: const InputDecoration(
                      labelText: 'Remain Amount: ',
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Goods'),
                    onPressed: () {
                      _showItemDialog(context, itemProvider);
                      setState() => {};
                    },
                  ),
                  ...goodsWidgets,
                ],
              ),
            ),
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                _addPurchaseOrder(
                  PurchaseOrder(
                    merchantName: selectedMerchant!.name,
                    totalPrice: double.parse(_totalPrice.text),
                    remainAmount: double.parse(_remainAmount.text),
                    goods: goods,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showItemDialog(
    BuildContext context,
    ItemProvider itemProvider,
  ) {
    Goods g = Goods(itemName: 'name', priceForGrams: 0, weightInGrams: 0);
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add item: '),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 20),

            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Item Name: '),
                      DropdownButton<Item>(
                        value: selectedItem,
                        items: itemProvider.items
                            .map(
                              (m) => DropdownMenuItem(
                                value: m,
                                child: Text(m.name),
                              ),
                            )
                            .toList(),
                        onChanged: (m) => {
                          setState(() => selectedItem = m),
                          g.itemName = selectedItem!.name,
                        },
                      ),
                    ],
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Price (g)'),
                    onChanged: (value) => g.priceForGrams = double.parse(value),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Wight (g)'),
                    onChanged: (value) => g.weightInGrams = double.parse(value),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              onPressed: () {
                goods.add(g);
                Navigator.pop(context);
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.cancel),
              label: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showPurchaseOrderDialog(List<Goods> goods) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Show Purchase Order'),
        content: SizedBox(
          width: double.maxFinite, // helps with layout in dialogs
          child: ListView.builder(
            shrinkWrap: true, // ✅ let ListView size itself
            physics:
                const NeverScrollableScrollPhysics(), // ✅ disable its own scrolling
            itemCount: goods.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name: ${goods[i].itemName}'),
                  Text('Price: ${goods[i].priceForGrams}'),
                  Text('Weight: ${goods[i].weightInGrams}'),
                ],
              ),
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
    final provider = context.watch<PurchaseOrderProvider>();
    final merchantProvider = context.watch<MerchantProvider>();
    final itemProvider = context.watch<ItemProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('PurchaseOrders', style: TextStyle()),
            Spacer(),
            IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
            IconButton(
              onPressed: () {
                _addPurchaseOrderDialog(
                  context,
                  merchantProvider,
                  itemProvider,
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: provider.purchaseOrders.length,
        itemBuilder: (_, i) => TextButton(
          onPressed: () =>
              _showPurchaseOrderDialog(provider.purchaseOrders[i].goods),
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child:
                        (provider.purchaseOrders[i].date?.isNotEmpty ?? false)
                        ? Text(provider.purchaseOrders[i].date!)
                        : const SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(provider.purchaseOrders[i].merchantName),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('${provider.purchaseOrders[i].totalPrice}'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('${provider.purchaseOrders[i].remainAmount}'),
                  ),
                  IconButton(
                    onPressed: () => _delete(provider.purchaseOrders[i]),
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
