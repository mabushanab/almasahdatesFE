// models/item.dart
import 'package:almasah_dates/features/saleOrder/data/models/product.dart';

class SaleOrder {
  final String? sOId;
  final String customerName;
  List<Product> products;
  final String? date;
  final double totalPrice;
  final double remainAmount;
  String? notes;

  SaleOrder({
    this.sOId,
    required this.customerName,
    required this.products,
    this.date,
    required this.totalPrice,
    required this.remainAmount,
    this.notes,
  });

  factory SaleOrder.fromJson(Map<String, dynamic> json) => SaleOrder(
    sOId: json['soid'],
    customerName: json['customerName'],
    products: (json['products'] as List<dynamic>)
        .map((g) => Product.fromJson(g))
        .toList(),
    date: json['date'],
    totalPrice: json['totalPrice'],
    remainAmount: json['remainAmount'],
    notes: json['notes'],
  );
  Map<String, dynamic> toJson() => {
    'soid': sOId,
    'customerName': customerName,
    'products': products.map((g) => g.toJson()).toList(),
    'date': date,
    'totalPrice': totalPrice,
    'remainAmount': remainAmount,
    'notes': notes,
  };
}
