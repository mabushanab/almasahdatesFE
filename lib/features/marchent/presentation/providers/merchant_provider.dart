// providers/merchant_provider.dart
import 'package:flutter/foundation.dart';

import '../../data/models/merchent.dart';
import '../../data/repositories/merchant_repository.dart';

class MerchantProvider extends ChangeNotifier {
  final MerchantRepository _repo = MerchantRepository();
  List<Merchant> merchants = [];
  bool isLoading = false;

  Future<void> loadMerchants() async {
    isLoading = true;
    notifyListeners();

    merchants = await _repo.getMerchants();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addMerchant(Merchant merchant) async {
    isLoading = true;
    notifyListeners();

    await _repo.addMerchant(merchant);
    loadMerchants();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteMerchant(Merchant merchant) async {
    isLoading = true;
    notifyListeners();

    await _repo.deleteMerchant(merchant.name);
    // await _repo.getMerchants();
    loadMerchants();

    isLoading = false;
    notifyListeners();
  }
}
