// repositories/item_repository.dart
import 'package:almasah_dates/features/marchent/data/services/merchants_service.dart';

import '../models/merchent.dart';

class MerchantRepository {
  final MerchantService _service = MerchantService();

  Future<List<Merchant>> getMerchants() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchMerchants();
  }

  Future<void> addMerchant(Merchant item) async {

    return await _service.addMerchant(item);
  }


  Future<void> deleteMerchant(String name) async {
    return await _service.deleteMerchant(name);

  }

}
