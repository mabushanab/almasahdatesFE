// repositories/item_repository.dart

import 'package:almasah_dates/features/customer/data/services/customer_service.dart';

import '../models/customer.dart';

class CustomerRepository {
  final CustomerService _service = CustomerService();

  Future<List<Customer>> getCustomers() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchCustomers();
  }

  Future<void> addCustomer(Customer item) async {

    return await _service.addCustomer(item);
  }


  Future<void> deleteCustomer(String name) async {
    return await _service.deleteCustomer(name);

  }

}
