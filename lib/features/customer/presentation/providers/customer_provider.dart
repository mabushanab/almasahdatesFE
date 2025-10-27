// providers/customer_provider.dart
import 'package:flutter/foundation.dart';

import '../../data/models/customer.dart';
import '../../data/repositories/customer_repository.dart';

class CustomerProvider extends ChangeNotifier {
  final CustomerRepository _repo = CustomerRepository();
  List<Customer> customers = [];
  bool isLoading = false;

  Future<void> loadCustomers() async {
    isLoading = true;
    notifyListeners();

    customers = await _repo.getCustomers();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addCustomer(Customer customer) async {
    isLoading = true;
    notifyListeners();

    await _repo.addCustomer(customer);
    loadCustomers();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteCustomer(Customer customer) async {
    isLoading = true;
    notifyListeners();

    await _repo.deleteCustomer(customer.name);
    // await _repo.getCustomers();
    loadCustomers();

    isLoading = false;
    notifyListeners();
  }
}
