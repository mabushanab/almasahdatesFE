import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:almasah_dates/features/purchaseOrder/data/models/goods.dart';
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
  final _formKey = GlobalKey<FormState>(); // Key to access the Form
  final _formKey1 = GlobalKey<FormState>(); // Key to access the Form

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ItemProvider>().loadItems());

    Future.microtask(() => context.read<MerchantProvider>().loadMerchants());
    Future.microtask(
      () => context.read<PurchaseOrderProvider>().loadPurchaseOrders(),
    );
  }

  bool _validateAddingPO() {
    // print(goods.first.itemName);
    // print(_formKey.currentState!.validate() || goods.isEmpty);
    return (_formKey.currentState!.validate() && goods.isNotEmpty);
  }

  bool _validateAddingItem() {
    return (_formKey1.currentState!.validate());
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Merchant Name: '),
                        Expanded(
                          // width: double.nan,
                          child: DropdownButtonFormField<Merchant>(
                            initialValue: selectedMerchant,
                            items: merchantProvider.merchants
                                .map(
                                  (m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(m.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (m) =>
                                setState(() => selectedMerchant = m),
                            validator: (value) {
                              if (value == null) {
                                return "Merchant is required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _totalPrice,
                      decoration: const InputDecoration(
                        labelText: 'Total Price: ',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Price is required";
                        }
                        final number = double.tryParse(value.trim());
                        if (number == null) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
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
                        _showItemDialog(context, itemProvider, setState);
                      },
                    ),
                    ...goodsWidgets,
                    ...goods.map(
                      (g) => ListTile(
                        title: Text(g.itemName),
                        subtitle: Text(
                          'Price: ${g.priceForGrams}, Qty: ${g.weightInGrams}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              goods.remove(g);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                if (_validateAddingPO()) {
                  _addPurchaseOrder(
                    PurchaseOrder(
                      merchantName: selectedMerchant!.name,
                      totalPrice: double.parse(_totalPrice.text),
                      remainAmount: double.tryParse(_remainAmount.text) ?? 0.0,
                      goods: goods,
                    ),
                  );
                  Navigator.pop(context);
                }
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
    void Function(void Function()) parentSetState,
  ) {
    Goods g = Goods(itemName: 'name', priceForGrams: 0, weightInGrams: 0);
    selectedItem = null;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add item: '),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Item Name: '),
                      Flexible(
                        child: DropdownButtonFormField<Item>(
                          initialValue: selectedItem,
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
                          validator: (value) {
                            if (value == null) {
                              return "Item is required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Price (g)'),
                    onChanged: (value) => g.priceForGrams = double.parse(value),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Price is required";
                      }
                      final number = double.tryParse(value.trim());
                      if (number == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Wight (g)'),
                    onChanged: (value) => g.weightInGrams = double.parse(value),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Weight is required";
                      }
                      final number = double.tryParse(value.trim());
                      if (number == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
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
                if (_validateAddingItem()) {
                  parentSetState(() {
                    goods.add(g);
                  });
                  Navigator.pop(context);
                }
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
    TextStyle style = TextStyle(
      fontSize: MediaQuery.of(context).size.width * .04,
    );
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Show Purchase Order'),
        content: SizedBox(
          width: double.maxFinite, // helps with layout in dialogs
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(children: [Text('Name', style: style)]),
                  Column(children: [Text('Price', style: style)]),
                  Column(children: [Text('Weight (g)', style: style)]),
                ],
              ),
              ListView.builder(
                shrinkWrap: true, // ✅ let ListView size itself
                physics:
                    const NeverScrollableScrollPhysics(), // ✅ disable its own scrolling
                itemCount: goods.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [Text(goods[i].itemName)]),
                      Column(children: [Text('${goods[i].priceForGrams}')]),
                      Column(children: [Text('${goods[i].weightInGrams}')]),
                    ],
                  ),
                ),
              ),
            ],
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
                    flex: 2,
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
