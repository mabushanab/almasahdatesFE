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
  // final _quantity = TextEditingController();
  Customer? selectedCustomer;
  Item? selectedItem;
  List<Widget> productWidgets = [];
  List<Product> product = [];
  int i = 0;
  final _formKey = GlobalKey<FormState>(); // Key to access the Form
  final _formKey1 = GlobalKey<FormState>(); // Key to access the Form

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ItemProvider>().loadItems());

    Future.microtask(() => context.read<CustomerProvider>().loadCustomers());
    Future.microtask(() => context.read<SaleOrderProvider>().loadSaleOrders());
  }

  bool _validateAddingSO() {
    return (_formKey.currentState!.validate() && product.isNotEmpty);
  }

  bool _validateAddingItem() {
    return (_formKey1.currentState!.validate());
  }

  Future<void> _refresh() async {
    await context.read<SaleOrderProvider>().loadSaleOrders();
  }

  Future<void> _addSaleOrder(SaleOrder saleOrder) async {
    await context.read<SaleOrderProvider>().addSaleOrder(saleOrder);
  }

  Future<void> _delete(SaleOrder saleOrder) async {
    await context.read<SaleOrderProvider>().deleteSaleOrder(saleOrder);
  }

  Future<dynamic> _addSaleOrderDialog(
    BuildContext context,
    CustomerProvider customerProvider,
    ItemProvider itemProvider,
  ) {
    // final itemProvider = context.watch<ItemProvider>();

    productWidgets.clear();
    product.clear();
    selectedCustomer = null;
    _remainAmount.clear();
    _totalPrice.clear();
    i = 0;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add saleOrder'),
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
                        Text('Customer Name: '),
                        Expanded(
                          child: DropdownButtonFormField<Customer>(
                            initialValue: selectedCustomer,
                            items: customerProvider.customers
                                .map(
                                  (m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(m.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (m) =>
                                setState(() => selectedCustomer = m),
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
                    TextFormField(
                      controller: _remainAmount,
                      decoration: const InputDecoration(
                        labelText: 'Remain Amount: ',
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Product'),
                      onPressed: () {
                        _showItemDialog(context, itemProvider, setState);
                      },
                    ),
                    ...product.map(
                      (g) => ListTile(
                        title: Text(g.itemName),
                        subtitle: Text(
                          'Price: ${g.priceForItem}, Qty: ${g.quantity}, Box: ${g.boxCost}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              product.remove(g);
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
                if (_validateAddingSO()) {
                  _addSaleOrder(
                    SaleOrder(
                      customerName: selectedCustomer!.name,
                      totalPrice: double.parse(_totalPrice.text),
                      remainAmount: double.tryParse(_remainAmount.text) ?? 0.0,
                      products: product,
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
    Product g = Product(
      itemName: 'name',
      priceForItem: 0,
      quantity: 0,
      boxCost: 0,
    );
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
                    decoration: const InputDecoration(
                      labelText: 'Price for item',
                    ),
                    onChanged: (value) => g.priceForItem = double.parse(value),
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
                    decoration: const InputDecoration(labelText: 'quantity'),
                    onChanged: (value) => g.quantity = int.parse(value),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Quantity is required";
                      }
                      final number = double.tryParse(value.trim());
                      if (number == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'box cost'),
                    onChanged: (value) =>
                        g.boxCost = double.tryParse(value) ?? 0.0,
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
                    product.add(g);
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

  Future<dynamic> _showSaleOrderDialog(List<Product> product) {
    TextStyle style = TextStyle(
      fontSize: MediaQuery.of(context).size.width * .04,
    );
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Show Sale Order'),
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
                itemCount: product.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [Text(product[i].itemName)]),
                      Column(children: [Text('${product[i].priceForItem}')]),
                      Column(children: [Text('${product[i].quantity}')]),
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
    final provider = context.watch<SaleOrderProvider>();
    final customerProvider = context.watch<CustomerProvider>();
    final itemProvider = context.watch<ItemProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('SaleOrders', style: TextStyle()),
            Spacer(),
            IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
            IconButton(
              onPressed: () {
                _addSaleOrderDialog(context, customerProvider, itemProvider);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: provider.saleOrders.length,
        itemBuilder: (_, i) => TextButton(
          onPressed: () =>
              _showSaleOrderDialog(provider.saleOrders[i].products),
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
                    child: (provider.saleOrders[i].date?.isNotEmpty ?? false)
                        ? Text(provider.saleOrders[i].date!)
                        : const SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(provider.saleOrders[i].customerName),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('${provider.saleOrders[i].totalPrice}'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('${provider.saleOrders[i].remainAmount}'),
                  ),
                  IconButton(
                    onPressed: () => _delete(provider.saleOrders[i]),
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
