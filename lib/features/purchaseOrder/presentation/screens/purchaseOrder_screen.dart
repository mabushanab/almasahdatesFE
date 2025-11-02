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
  final _priceForGram = TextEditingController();

  Merchant? selectedMerchant;
  Item? selectedItem;
  final List<Goods> goodsList = [];
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  double sum = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ItemProvider>().loadItems();
      context.read<MerchantProvider>().loadMerchants();
      context.read<PurchaseOrderProvider>().loadPurchaseOrders();
    });
  }

  bool _validatePO() => _formKey.currentState!.validate() && goodsList.isNotEmpty;
  bool _validateGoods() => _formKey1.currentState!.validate();

  Future<void> _refresh() async =>
      context.read<PurchaseOrderProvider>().loadPurchaseOrders();

  Future<String> _getMinGoodsPrice(String name) async =>
      context.read<PurchaseOrderProvider>().getMinGoodsPrice(name);

  Future<void> _addPurchaseOrder(PurchaseOrder order) async =>
      context.read<PurchaseOrderProvider>().addPurchaseOrder(order);

  Future<void> _getInvoice(String pOId) async =>
      context.read<PurchaseOrderProvider>().getInvoice(pOId);

  // ==============================
  // 💬 Add Purchase Order Dialog
  // ==============================
  Future<void> _showAddPurchaseOrderDialog(
    BuildContext context,
    MerchantProvider merchantProvider,
    ItemProvider itemProvider,
  ) async {
    goodsList.clear();
    selectedMerchant = null;
    _remainAmount.clear();
    _totalPrice.clear();
    sum = 0;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Purchase Order'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<Merchant>(
                    decoration: const InputDecoration(labelText: 'Merchant Name'),
                    value: selectedMerchant,
                    items: merchantProvider.merchants
                        .map((m) => DropdownMenuItem(
                              value: m,
                              child: Text(m.name),
                            ))
                        .toList(),
                    onChanged: (m) => setState(() => selectedMerchant = m),
                    validator: (v) => v == null ? "Merchant required" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _totalPrice,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Total Price',
                      prefixIcon: Icon(Icons.calculate),
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? "Required" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _remainAmount,
                    decoration: const InputDecoration(
                      labelText: 'Remaining Amount',
                      prefixIcon: Icon(Icons.money),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Goods'),
                    onPressed: () =>
                        _showAddGoodsDialog(context, itemProvider, setState),
                  ),
                  const SizedBox(height: 12),
                  ...goodsList.map(
                    (g) => Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(g.itemName),
                        subtitle:
                            Text('Price: ${g.priceForGrams}, Qty: ${g.weightInGrams}g'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              sum -= (g.priceForGrams * g.weightInGrams);
                              goodsList.remove(g);
                              _totalPrice.text = sum.toStringAsFixed(2);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            FilledButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Save'),
              onPressed: () {
                if (_validatePO()) {
                  _addPurchaseOrder(
                    PurchaseOrder(
                      merchantName: selectedMerchant!.name,
                      totalPrice: double.parse(_totalPrice.text),
                      remainAmount:
                          double.tryParse(_remainAmount.text) ?? 0.0,
                      goods: goodsList,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
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

  // ==============================
  // 📦 Add Goods Dialog
  // ==============================
  Future<void> _showAddGoodsDialog(
    BuildContext context,
    ItemProvider itemProvider,
    void Function(void Function()) parentSetState,
  ) async {
    final Goods g = Goods(itemName: '', priceForGrams: 0, weightInGrams: 0);
    _priceForGram.clear();
    selectedItem = null;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Goods'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Form(
            key: _formKey1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<Item>(
                  decoration: const InputDecoration(labelText: 'Item'),
                  value: selectedItem,
                  items: itemProvider.items
                      .map((i) => DropdownMenuItem(
                            value: i,
                            child: Text(i.name),
                          ))
                      .toList(),
                  onChanged: (i) async {
                    setState(() => selectedItem = i);
                    g.itemName = i!.name;
                    _priceForGram.text = await _getMinGoodsPrice(i.name);
                    g.priceForGrams = double.parse(_priceForGram.text);
                  },
                  validator: (v) => v == null ? "Item required" : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _priceForGram,
                  decoration: const InputDecoration(labelText: 'Price per gram'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => g.priceForGrams = double.tryParse(v) ?? 0.0,
                  validator: (v) => (v == null || v.isEmpty)
                      ? "Price required"
                      : double.tryParse(v) == null
                          ? "Invalid number"
                          : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Weight (grams)'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => g.weightInGrams = double.tryParse(v) ?? 0.0,
                  validator: (v) => (v == null || v.isEmpty)
                      ? "Weight required"
                      : double.tryParse(v) == null
                          ? "Invalid number"
                          : null,
                ),
              ],
            ),
          ),
          actions: [
            FilledButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              onPressed: () {
                if (_validateGoods()) {
                  parentSetState(() {
                    goodsList.add(g);
                    sum += g.priceForGrams * g.weightInGrams;
                    _totalPrice.text = sum.toStringAsFixed(2);
                  });
                  Navigator.pop(context);
                }
              },
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

  // ==============================
  // 🧾 Show Purchase Order Details
  // ==============================
  Future<void> _showPurchaseOrderDialog(List<Goods> goods,String pOId) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('PO: $pOId'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Price'),
                  Text('Weight'),
                ],
              ),
              const Divider(),
              ...goods.map((g) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(g.itemName),
                        Text('${g.priceForGrams}'),
                        Text('${g.weightInGrams}'),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // ==============================
  // 🧱 Main UI
  // ==============================
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PurchaseOrderProvider>();
    final merchants = context.watch<MerchantProvider>();
    final items = context.watch<ItemProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Orders'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: () => _showAddPurchaseOrderDialog(context, merchants, items),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: provider.purchaseOrders.length,
          itemBuilder: (_, i) {
            final po = provider.purchaseOrders[i];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                onTap: () => _showPurchaseOrderDialog(po.goods,po.pOId ?? ''),
                title: Text(po.merchantName),
                subtitle: Text('${po.date} •  Total: ${po.totalPrice} • Remain: ${po.remainAmount}'),
                trailing: IconButton(
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                  onPressed: () => _getInvoice(po.pOId!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
