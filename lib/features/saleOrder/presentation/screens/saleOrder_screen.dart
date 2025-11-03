import 'package:almasah_dates/features/customer/data/models/customer.dart';
import 'package:almasah_dates/features/customer/presentation/providers/customer_provider.dart';
import 'package:almasah_dates/features/items/data/models/item.dart';
import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:almasah_dates/features/saleOrder/data/models/product.dart';
import 'package:almasah_dates/features/saleOrder/data/models/saleOrder.dart';
import 'package:almasah_dates/features/saleOrder/presentation/providers/saleOrder_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleOrderListScreen extends StatefulWidget {
  const SaleOrderListScreen({super.key});

  @override
  State<SaleOrderListScreen> createState() => _SaleOrderListScreenState();
}

class _SaleOrderListScreenState extends State<SaleOrderListScreen> {
  final _totalPrice = TextEditingController();
  final _remainAmount = TextEditingController();
  final _priceForItem = TextEditingController();

  Customer? selectedCustomer;
  Item? selectedItem;
  final List<Product> products = [];
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  double sum = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ItemProvider>().loadItems();
      context.read<CustomerProvider>().loadCustomers();
      context.read<SaleOrderProvider>().loadSaleOrders();
    });
  }

  bool _validateSO() =>
      _formKey.currentState!.validate() && products.isNotEmpty;
  bool _validateItem() => _formKey1.currentState!.validate();

  Future<void> _refresh() async =>
      await context.read<SaleOrderProvider>().loadSaleOrders();

  Future<String> _getMaxProductPrice(String name) async =>
      context.read<SaleOrderProvider>().getMaxProductPrice(name);

  Future<String> _getProductPrice(String name) async =>
      context.read<SaleOrderProvider>().getProductPrice(name);

  Future<void> _addSaleOrder(SaleOrder order) async =>
      context.read<SaleOrderProvider>().addSaleOrder(order);

  Future<void> _getInvoice(String name) async =>
      context.read<SaleOrderProvider>().getInvoice(name);

  Future<void> _payRemain(String sOId) async =>
      context.read<SaleOrderProvider>().payRemain(sOId);
  // ==============================
  // 💬 Add Sale Order Dialog
  // ==============================
  Future<void> _showAddSaleOrderDialog(
    BuildContext context,
    CustomerProvider customerProvider,
    ItemProvider itemProvider,
  ) async {
    products.clear();
    selectedCustomer = null;
    _remainAmount.clear();
    _totalPrice.clear();
    sum = 0;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Sale Order'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<Customer>(
                    decoration: const InputDecoration(
                      labelText: 'Customer Name',
                    ),
                    value: selectedCustomer,
                    items: customerProvider.customers
                        .map(
                          (c) =>
                              DropdownMenuItem(value: c, child: Text(c.name)),
                        )
                        .toList(),
                    onChanged: (c) => setState(() => selectedCustomer = c),
                    validator: (v) => v == null ? "Customer is required" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _totalPrice,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Total Price (JOD)',
                      prefixIcon: Icon(Icons.calculate),
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? "Required" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _remainAmount,
                    decoration: const InputDecoration(
                      labelText: 'Remaining Amount',
                      prefixIcon: Icon(Icons.money),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Product'),
                    onPressed: () =>
                        _showAddItemDialog(context, itemProvider, setState),
                  ),
                  const SizedBox(height: 12),
                  ...products.map(
                    (g) => Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(g.itemName),
                        subtitle: Text(
                          'Price: ${g.priceForItem}, Qty: ${g.quantity}, Discount: ${g.discount}%, Total: ${(g.priceForItem * g.quantity - ((g.priceForItem * g.quantity) * (g.discount / 100))).toStringAsFixed(2)}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              sum -= (g.priceForItem * g.quantity - ((g.priceForItem * g.quantity) * (g.discount / 100)));
                              products.remove(g);
                              _totalPrice.text = (sum.toStringAsFixed(
                                2,
                              )).toString();
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
                if (_validateSO()) {
                  _addSaleOrder(
                    SaleOrder(
                      customerName: selectedCustomer!.name,
                      totalPrice: double.parse(_totalPrice.text),
                      remainAmount: double.tryParse(_remainAmount.text) ?? 0.0,
                      products: products,
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
  // 📦 Add Product Dialog
  // ==============================
  Future<void> _showAddItemDialog(
    BuildContext context,
    ItemProvider itemProvider,
    void Function(void Function()) parentSetState,
  ) async {
    final Product p = Product(
      itemName: '',
      priceForItem: 0,
      quantity: 0,
      boxCost: 0,
      discount: 0,
    );
    _priceForItem.clear();
    selectedItem = null;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Product'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Form(
            key: _formKey1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<Item>(
                  decoration: const InputDecoration(labelText: 'Item'),
                  value: selectedItem,
                  items: itemProvider.items
                      .map(
                        (i) => DropdownMenuItem(value: i, child: Text(i.name)),
                      )
                      .toList(),
                  onChanged: (i) async {
                    setState(() => selectedItem = i);
                    p.itemName = i!.name;
                    _priceForItem.text = await _getProductPrice(i.name);
                    p.priceForItem = double.tryParse(_priceForItem.text) ?? 0.0;
                  },
                  validator: (v) => v == null ? "Item required" : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _priceForItem,
                  decoration: const InputDecoration(
                    labelText: 'Price per Item',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => p.priceForItem = double.tryParse(v) ?? 0.0,
                  validator: (v) => (v == null || v.isEmpty)
                      ? "Price required"
                      : double.tryParse(v) == null
                      ? "Invalid number"
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => p.quantity = int.tryParse(v) ?? 0,
                  validator: (v) => (v == null || v.isEmpty)
                      ? "Quantity required"
                      : int.tryParse(v) == null
                      ? "Invalid number"
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Discount (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => p.discount = int.tryParse(v) ?? 0,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter a number';
                    final numValue = num.tryParse(v);
                    if (numValue == null) return 'Not a valid number';
                    if (numValue is int ||
                        numValue == numValue.roundToDouble()) {
                      return null;
                    } else {
                      return 'Must be a whole number';
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            FilledButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              onPressed: () {
                if (_validateItem()) {
                  parentSetState(() {
                    products.add(p);
                    sum += (p.priceForItem * p.quantity - ((p.priceForItem * p.quantity) * (p.discount / 100)));
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
  // 🧾 Show Sale Order Details
  // ==============================
  Future<void> _showSaleOrderDialog(List<Product> products, String sOId) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('SO: $sOId'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Price'),
                  Text('Qty'),
                ],
              ),
              const Divider(),
              ...products.map(
                (p) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(p.itemName),
                      Text('${p.priceForItem}'),
                      Text('${p.quantity}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _payRemain(sOId);
              Navigator.pop(context);
            },
            child: const Text('Pay Remain'),
          ),
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
    final provider = context.watch<SaleOrderProvider>();
    final customers = context.watch<CustomerProvider>();
    final items = context.watch<ItemProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Orders'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: () => _showAddSaleOrderDialog(context, customers, items),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: provider.saleOrders.length,
          itemBuilder: (_, i) {
            final so = provider.saleOrders[i];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                onTap: () => _showSaleOrderDialog(so.products, so.sOId ?? ''),
                title: Text(so.customerName),
                subtitle: Text(
                  '${so.date} •  Total: ${so.totalPrice} • Remain: ${so.remainAmount}',
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.redAccent,
                  ),
                  onPressed: () => _getInvoice(so.sOId ?? ''),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
