import 'package:almasah_dates/features/home/data/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/home.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository _repo = HomeRepository();
  Home home= Home(sumPO: 0, sumPORemain: 0, sumSO: 0, sumSORemain: 0, avgProductPrice: {}, avgGoodPrice: {}, avgProductPriceWithBox: {}, avgProfitPerItem: {}, totalProfitPerItem: {});
  bool isLoading = false;

  Future<void> loadHomes() async {
    isLoading = true;
    notifyListeners();

    home = await _repo.getHomeDetails();

    isLoading = false;
    notifyListeners();
  }
}
