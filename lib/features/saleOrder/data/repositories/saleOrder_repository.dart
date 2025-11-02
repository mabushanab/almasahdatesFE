// repositories/item_repository.dart

import 'package:almasah_dates/features/saleOrder/data/services/saleOrder_service.dart';

import '../models/saleOrder.dart';

class SaleOrderRepository {
  final SaleOrderService _service = SaleOrderService();

  Future<List<SaleOrder>> getSaleOrders() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchSaleOrders();
  }

  Future<void> addSaleOrder(SaleOrder saleOrder) async {
    return await _service.addSaleOrder(saleOrder);
  }

  Future<String> getMaxProductPrice(String goodsName) async {
    return await _service.getMaxProductPrice(goodsName);
  }

  Future<String> getProductPrice(String goodsName) async {
    return await _service.getProductPrice(goodsName);
  }

  Future<void> deleteSaleOrder(String name) async {
    return await _service.deleteSaleOrder(name);
  }

  Future<void> getInvoice(String name) async {
    return await _service.getInvoice(name);
  }

  Future<void> payRemain(String name) async {
    return await _service.payRemain(name);
  }
}
