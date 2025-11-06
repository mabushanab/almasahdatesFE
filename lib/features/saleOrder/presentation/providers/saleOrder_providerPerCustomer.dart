// providers/saleOrder_provider.dart
import 'package:almasah_dates/features/saleOrder/data/models/saleOrderPerCustomer.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/saleOrder.dart';
import '../../data/repositories/saleOrder_repository.dart';

class SaleOrderProviderPerCustomer extends ChangeNotifier {
  final SaleOrderRepository _repo = SaleOrderRepository();
  List<SaleOrder> saleOrders = [];
  bool isLoading = false;
  double remain =0;
  double total=0;

  Future<void> loadSaleOrdersForCustomer(String name) async {
    isLoading = true;
    notifyListeners();
    
    SaleOrderPerCustomer t = await _repo.fetchSaleOrdersForCustomer(name);
    saleOrders = t.saleOrderPerCustomer;
    remain = t.remain;
    total = t.total;
    isLoading = false;
    notifyListeners();
  }

  Future<void> addSaleOrder(SaleOrder saleOrder) async {
    isLoading = true;
    notifyListeners();

    await _repo.addSaleOrder(saleOrder);

    isLoading = false;
    notifyListeners();
  }

  Future<String> getMaxProductPrice(String goodsName) async {
    isLoading = true;
    notifyListeners();

    String s = await _repo.getMaxProductPrice(goodsName);

    isLoading = false;
    notifyListeners();
    return s;
  }

  Future<String> getProductPrice(String goodsName) async {
    isLoading = true;
    notifyListeners();

    String s = await _repo.getProductPrice(goodsName);

    isLoading = false;
    notifyListeners();
    return s;
  }

  Future<void> getInvoice(String name) async {
    isLoading = true;
    notifyListeners();

    await _repo.getInvoice(name);

    isLoading = false;
    notifyListeners();
  }

  Future<void> payRemain(String name) async {
    isLoading = true;
    notifyListeners();

    await _repo.payRemain(name);

    isLoading = false;
    notifyListeners();
  }
}
