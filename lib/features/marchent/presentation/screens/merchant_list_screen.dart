import 'package:almasah_dates/features/marchent/data/models/merchent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:almasah_dates/features/marchent/presentation/providers/merchant_provider.dart';

class MerchantListScreen extends StatefulWidget {
  const MerchantListScreen({super.key});

  @override
  State<MerchantListScreen> createState() => _MerchantListScreenState();
}

class _MerchantListScreenState extends State<MerchantListScreen> {
  final _formKey = GlobalKey<FormState>();
  final _merchantName = TextEditingController();
  final _merchantType = TextEditingController();
  final _merchantAddress = TextEditingController();
  final _merchantMobileNumber = TextEditingController();
  final _merchantNotes = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MerchantProvider>().loadMerchants());
  }

  Future<void> _refresh() async =>
      context.read<MerchantProvider>().loadMerchants();

  Future<void> _addMerchant(Merchant m) async =>
      context.read<MerchantProvider>().addMerchant(m);

  Future<void> _deleteMerchant(Merchant m) async =>
      context.read<MerchantProvider>().deleteMerchant(m);

  bool _isFormValid() => _formKey.currentState!.validate();

  void _showAddMerchantDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Merchant', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                _buildField(_merchantName, 'Name', validator: true),
                _buildField(_merchantType, 'Type', validator: true),
                _buildField(_merchantMobileNumber, 'Mobile Number'),
                _buildField(_merchantAddress, 'Address'),
                _buildField(_merchantNotes, 'Notes'),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add'),
            onPressed: () {
              if (_isFormValid()) {
                _addMerchant(Merchant(
                  name: _merchantName.text,
                  type: _merchantType.text,
                  address: _merchantAddress.text,
                  mobileNumber: _merchantMobileNumber.text,
                  notes: _merchantNotes.text,
                ));
                Navigator.pop(context);
              }
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      {bool validator = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator
            ? (v) => (v == null || v.trim().isEmpty) ? '$label is required' : null
            : null,
      ),
    );
  }

  void _showDetails(Merchant m) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Merchant Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow('Name', m.name),
            _detailRow('Type', m.type),
            _detailRow('Mobile', m.mobileNumber),
            _detailRow('Address', m.address),
            _detailRow('Notes', m.notes),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  Widget _detailRow(String title, String? value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text('$title: ${value ?? ''}', style: const TextStyle(fontSize: 14)),
      );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MerchantProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchants'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _showAddMerchantDialog, icon: const Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: provider.merchants.length,
          itemBuilder: (_, i) {
            final m = provider.merchants[i];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ListTile(
                title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(m.type),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteMerchant(m),
                ),
                onTap: () => _showDetails(m),
              ),
            );
          },
        ),
      ),
    );
  }
}
