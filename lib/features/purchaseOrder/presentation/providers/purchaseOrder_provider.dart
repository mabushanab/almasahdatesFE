// providers/purchaseOrder_provider.dart
import 'package:flutter/foundation.dart';

import '../../data/models/purchaseOrder.dart';
import '../../data/repositories/purchaseOrder_repository.dart';

class PurchaseOrderProvider extends ChangeNotifier {
  final PurchaseOrderRepository _repo = PurchaseOrderRepository();
  List<PurchaseOrder> purchaseOrders = [];
  bool isLoading = false;

  Future<void> loadPurchaseOrders() async {
    isLoading = true;
    notifyListeners();

    purchaseOrders = await _repo.getPurchaseOrders();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addPurchaseOrder(PurchaseOrder purchaseOrder) async {
    isLoading = true;
    notifyListeners();

    await _repo.addPurchaseOrder(purchaseOrder);
    loadPurchaseOrders();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePurchaseOrder(PurchaseOrder purchaseOrder) async {
    isLoading = true;
    notifyListeners();

    await _repo.deletePurchaseOrder(purchaseOrder.merchantName);
    // await _repo.getPurchaseOrders();
    loadPurchaseOrders();

    isLoading = false;
    notifyListeners();
  }

    Future<String> getMinGoodsPrice(String goodsName) async {
    isLoading = true;
    notifyListeners();

    String s =await _repo.getMinGoodsPrice(goodsName);
    loadPurchaseOrders();

    isLoading = false;
    notifyListeners();
    return s;
  }

  Future<void> getInvoice(String name) async {
    isLoading = true;
    notifyListeners();

    await _repo.getInvoice(name);
    loadPurchaseOrders();

    isLoading = false;
    notifyListeners();
  }
  Future<void> payRemain(String name) async {
    isLoading = true;
    notifyListeners();

    await _repo.payRemain(name);
    loadPurchaseOrders();

    isLoading = false;
    notifyListeners();
  }

}
