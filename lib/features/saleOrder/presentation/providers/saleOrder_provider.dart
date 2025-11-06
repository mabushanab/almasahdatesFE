// providers/saleOrder_provider.dart
import 'package:flutter/foundation.dart';

import '../../data/models/saleOrder.dart';
import '../../data/repositories/saleOrder_repository.dart';

class SaleOrderProvider extends ChangeNotifier {
  final SaleOrderRepository _repo = SaleOrderRepository();
  List<SaleOrder> saleOrders = [];
  bool isLoading = false;

  Future<void> loadSaleOrders() async {
    isLoading = true;
    notifyListeners();

    // Future.delayed(const Duration(milliseconds: 2221300));
    saleOrders = await _repo.getSaleOrders();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addSaleOrder(SaleOrder saleOrder) async {
    isLoading = true;
    notifyListeners();

    await _repo.addSaleOrder(saleOrder);
    loadSaleOrders();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteSaleOrder(SaleOrder saleOrder) async {
    isLoading = true;
    notifyListeners();

    await _repo.deleteSaleOrder(saleOrder.customerName);
    loadSaleOrders();

    isLoading = false;
    notifyListeners();
  }

  Future<String> getMaxProductPrice(String goodsName) async {
    isLoading = true;
    notifyListeners();

    String s = await _repo.getMaxProductPrice(goodsName);
    loadSaleOrders();

    isLoading = false;
    notifyListeners();
    return s;
  }

  Future<String> getProductPrice(String goodsName) async {
    isLoading = true;
    notifyListeners();

    String s = await _repo.getProductPrice(goodsName);
    loadSaleOrders();

    isLoading = false;
    notifyListeners();
    return s;
  }

  Future<void> getInvoice(String name) async {
    isLoading = true;
    notifyListeners();

    await _repo.getInvoice(name);
    loadSaleOrders();

    isLoading = false;
    notifyListeners();
  }

  Future<void> payRemain(String name) async {
    isLoading = true;
    notifyListeners();

    await _repo.payRemain(name);
    loadSaleOrders();

    isLoading = false;
    notifyListeners();
  }

  // Future<void> loadSaleOrdersForCustomer(String name) async {
  //   isLoading = true;
  //   notifyListeners();
    
  //   saleOrders = await _repo.fetchSaleOrdersForCustomer(name);    
    

  //   isLoading = false;
  //   notifyListeners();
  // }
}
