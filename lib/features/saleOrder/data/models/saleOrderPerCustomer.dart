// models/item.dart
import 'package:almasah_dates/features/saleOrder/data/models/saleOrder.dart';

class SaleOrderPerCustomer {
  final List<SaleOrder> saleOrderPerCustomer;
  final double remain;
  final double total;

  SaleOrderPerCustomer({
    required this.saleOrderPerCustomer,
    required this.remain,
    required this.total,
  });

  factory SaleOrderPerCustomer.fromJson(Map<String, dynamic> json) => SaleOrderPerCustomer(
    // saleOrderPerCustomer: json['saleOrders'],
    remain: json['remain'],
    total: json['total'],
    saleOrderPerCustomer: (json['saleOrders'] as List<dynamic>)
        .map((g) => SaleOrder.fromJson(g))
        .toList(),
  );
  Map<String, dynamic> toJson() => {
    'remain': remain,
    'total': total,
    'saleOrders': saleOrderPerCustomer.map((g) => g.toJson()).toList(),
  };
}
