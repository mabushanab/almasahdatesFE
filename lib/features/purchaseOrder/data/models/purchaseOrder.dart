// models/item.dart
import 'package:almasah_dates/features/goods/data/models/goods.dart';

class PurchaseOrder {
  final String merchantName;
  final List<Goods> goods;
  final String date;
  final double totalPrice;
  final double remainAmount;
  String? notes;

  PurchaseOrder({
    required this.merchantName,
    required this.goods,
    required this.date,
    required this.totalPrice,
    required this.remainAmount,
    this.notes,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => PurchaseOrder(
    merchantName: json['merchantName'],
    goods: (json['goods'] as List<dynamic>).map((g) => Goods.fromJson(g as Map<String, dynamic>)).toList() ,
    date: json['date'],
    totalPrice: json['totalPrice'],
    remainAmount: json['remainAmount'],
    notes: json['notes'],

  );
}
