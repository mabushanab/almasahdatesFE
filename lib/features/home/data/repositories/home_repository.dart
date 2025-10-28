import 'package:almasah_dates/features/home/data/services/home_service.dart';
import '../models/home.dart';

class HomeRepository {
  final HomeService _service = HomeService();

  Future<Home> getHomeDetails() async {
    // In a real app, we could check local cache first
    // or handle errors/retries here
    return await _service.fetchHomeDetails();
  }

}
