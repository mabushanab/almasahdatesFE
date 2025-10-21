// screens/merchant_list_screen.dart
import 'package:almasah_dates/features/marchent/data/models/merchent.dart';
import 'package:almasah_dates/features/marchent/presentation/providers/merchant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MerchantListScreen extends StatefulWidget {
  const MerchantListScreen({super.key});

  @override
  State<MerchantListScreen> createState() => _MerchantListScreenState();
}

class _MerchantListScreenState extends State<MerchantListScreen> {
  final _merchantName = TextEditingController();
  final _merchantType = TextEditingController();
  final _merchantAddress = TextEditingController();
  final _merchantMobileNumber = TextEditingController();
  final _merchantNotes = TextEditingController();
  // final _merchantRate = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ Load merchants once when the screen opens
    Future.microtask(() => context.read<MerchantProvider>().loadMerchants());
  }

  // List merchants =;
  Future<void> _refresh() async {
    await context.read<MerchantProvider>().loadMerchants();
  }

  Future<void> _addMerchant(Merchant merchant) async {
    await context.read<MerchantProvider>().addMerchant(merchant);
  }

  Future<void> _delete(Merchant merchant) async {
    await context.read<MerchantProvider>().deleteMerchant(merchant);
  }

  Future<dynamic> _addMerchantDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add merchant'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400, // prevent infinite height
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _merchantName,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _merchantType,
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                TextField(
                  controller: _merchantMobileNumber,
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                ),
                TextField(
                  controller: _merchantAddress,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                                TextField(
                  controller: _merchantNotes,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
        ),

        actions: [
          ElevatedButton(
            onPressed: () {
              _addMerchant(Merchant(name: _merchantName.text, type: _merchantType.text,address: _merchantAddress.text, mobileNumber: _merchantMobileNumber.text,notes: _merchantNotes.text));
              Navigator.pop(context); // close popup
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

  Future<dynamic> _showMerchantDialog(Merchant merchant) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Show merchant'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400, // prevent infinite height
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: ${merchant.name}'),
                Text('Type: ${merchant.type}'),
                Text('Mobile: ${merchant.mobileNumber}'),
                Text('Addr: ${merchant.address}'),
                Text('Notes: ${merchant.notes}'),
                Text('Rate: ${merchant.rate}'),
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
    final provider = context.watch<MerchantProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Merchants', style: TextStyle()),
            Spacer(),
            IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
            IconButton(
              onPressed: () {
                _addMerchantDialog(context);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: provider.merchants.length,
        itemBuilder: (_, i) => TextButton(
          onPressed: () => _showMerchantDialog(provider.merchants[i]),

          // context);
          // onPressed: () {
          // _showMerchantDialog(provider.merchants[i],
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
                Text(provider.merchants[i].name),
                const Spacer(),
                IconButton(
                  onPressed: () => _delete(provider.merchants[i]),
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
