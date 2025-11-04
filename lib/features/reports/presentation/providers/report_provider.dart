import 'package:almasah_dates/features/reports/data/repositories/report_repository.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/report.dart';

class ReportProvider extends ChangeNotifier {
  final ReportRepository _repo = ReportRepository();
  Report report= Report(sumPO: 0, sumPORemain: 0, sumSO: 0, sumSORemain: 0, avgProductPrice: {}, avgGoodPrice: {}, avgProductPriceWithBox: {}, avgProfitPerItem: {}, totalProfitPerItem: {});
  bool isLoading = false;

  Future<void> loadReports() async {
    isLoading = true;
    notifyListeners();

    report = await _repo.getReportDetails();

    isLoading = false;
    notifyListeners();
  }
}
