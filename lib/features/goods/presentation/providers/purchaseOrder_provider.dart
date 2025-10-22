// // providers/purchaseOrder_provider.dart
// import 'package:flutter/foundation.dart';

// import '../../data/models/goods.dart';
// import '../../data/repositories/purchaseOrder_repository.dart';

// class PurchaseOrderProvider extends ChangeNotifier {
//   final PurchaseOrderRepository _repo = PurchaseOrderRepository();
//   List<PurchaseOrder> purchaseOrders = [];
//   bool isLoading = false;

//   Future<void> loadPurchaseOrders() async {
//     isLoading = true;
//     notifyListeners();

//     purchaseOrders = await _repo.getPurchaseOrders();

//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> addPurchaseOrder(PurchaseOrder purchaseOrder) async {
//     isLoading = true;
//     notifyListeners();

//     await _repo.addPurchaseOrder(purchaseOrder);
//     loadPurchaseOrders();

//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> deletePurchaseOrder(PurchaseOrder purchaseOrder) async {
//     isLoading = true;
//     notifyListeners();

//     await _repo.deletePurchaseOrder(purchaseOrder.name);
//     // await _repo.getPurchaseOrders();
//     loadPurchaseOrders();

//     isLoading = false;
//     notifyListeners();
//   }
// }
