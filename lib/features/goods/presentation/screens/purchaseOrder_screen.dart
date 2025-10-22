// import 'package:almasah_dates/features/purchaseOrder/data/models/purchaseOrder.dart';
// import 'package:almasah_dates/features/purchaseOrder/presentation/providers/purchaseOrder_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class PurchaseOrderListScreen extends StatefulWidget {
//   const PurchaseOrderListScreen({super.key});

//   @override
//   State<PurchaseOrderListScreen> createState() => _PurchaseOrderListScreenState();
// }

// class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
//   final _purchaseOrderName = TextEditingController();
//   final _purchaseOrderType = TextEditingController();
//   final _purchaseOrderAddress = TextEditingController();
//   final _purchaseOrderMobileNumber = TextEditingController();
//   final _purchaseOrderNotes = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() => context.read<PurchaseOrderProvider>().loadPurchaseOrders());
//   }

//   // List purchaseOrders =;
//   Future<void> _refresh() async {
//     await context.read<PurchaseOrderProvider>().loadPurchaseOrders();
//   }

//   Future<void> _addPurchaseOrder(PurchaseOrder purchaseOrder) async {
//     await context.read<PurchaseOrderProvider>().addPurchaseOrder(purchaseOrder);
//   }

//   Future<void> _delete(PurchaseOrder purchaseOrder) async {
//     await context.read<PurchaseOrderProvider>().deletePurchaseOrder(purchaseOrder);
//   }

//   Future<dynamic> _addPurchaseOrderDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add purchaseOrder'),
//         content: ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxHeight: 400, // prevent infinite height
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: _purchaseOrderName,
//                   decoration: const InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   controller: _purchaseOrderType,
//                   decoration: const InputDecoration(labelText: 'Type'),
//                 ),
//                 TextField(
//                   controller: _purchaseOrderMobileNumber,
//                   decoration: const InputDecoration(labelText: 'Mobile Number'),
//                 ),
//                 TextField(
//                   controller: _purchaseOrderAddress,
//                   decoration: const InputDecoration(labelText: 'Address'),
//                 ),
//                                 TextField(
//                   controller: _purchaseOrderNotes,
//                   decoration: const InputDecoration(labelText: 'Notes'),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               _addPurchaseOrder(PurchaseOrder(name: _purchaseOrderName.text, type: _purchaseOrderType.text,address: _purchaseOrderAddress.text, mobileNumber: _purchaseOrderMobileNumber.text,notes: _purchaseOrderNotes.text));
//               Navigator.pop(context); // close popup
//             },
//             child: const Text('Add'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context), // close dialog
//             child: const Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<dynamic> _showPurchaseOrderDialog(PurchaseOrder purchaseOrder) {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Show purchaseOrder'),
//         content: ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxHeight: 400, // prevent infinite height
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Name: ${purchaseOrder.name}'),
//                 Text('Type: ${purchaseOrder.type}'),
//                 Text('Mobile: ${purchaseOrder.mobileNumber}'),
//                 Text('Addr: ${purchaseOrder.address}'),
//                 Text('Notes: ${purchaseOrder.notes}'),
//                 Text('Rate: ${purchaseOrder.rate}'),
//                 ],
//             ),
//           ),
//         ),

//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), // close dialog
//             child: const Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<PurchaseOrderProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text('PurchaseOrders', style: TextStyle()),
//             Spacer(),
//             IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
//             IconButton(
//               onPressed: () {
//                 _addPurchaseOrderDialog(context);
//               },
//               icon: Icon(Icons.add),
//             ),
//           ],
//         ),
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.zero,
//         itemCount: provider.purchaseOrders.length,
//         itemBuilder: (_, i) => TextButton(
//           onPressed: () => _showPurchaseOrderDialog(provider.purchaseOrders[i]),
//           child: Card(
//             elevation: 3,
//             margin: const EdgeInsets.symmetric(vertical: 2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(provider.purchaseOrders[i].name),
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () => _delete(provider.purchaseOrders[i]),
//                   icon: Icon(Icons.delete),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
