import 'package:almasah_dates/features/reports/data/services/report_service.dart';

import '../models/report.dart';

class ReportRepository {
  final ReportService _service = ReportService();

  Future<Report> getReportDetails() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchReportDetails();
  }

}
