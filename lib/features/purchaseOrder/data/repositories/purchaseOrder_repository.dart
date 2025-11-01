// repositories/item_repository.dart
import 'package:almasah_dates/features/purchaseOrder/data/services/purchaseOrder_service.dart';

import '../models/purchaseOrder.dart';

class PurchaseOrderRepository {
  final PurchaseOrderService _service = PurchaseOrderService();

  Future<List<PurchaseOrder>> getPurchaseOrders() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchPurchaseOrders();
  }

  Future<void> addPurchaseOrder(PurchaseOrder purchaseOrder) async {
    return await _service.addPurchaseOrder(purchaseOrder);
  }

  Future<void> deletePurchaseOrder(String name) async {
    return await _service.deletePurchaseOrder(name);
  }

  Future<String> getMinGoodsPrice(String goodsName) async {
    return await _service.getMinGoodsPrice(goodsName);
  }

  Future<void> getInvoice(String name) async {
    return await _service.getInvoice(name);
  }
}
