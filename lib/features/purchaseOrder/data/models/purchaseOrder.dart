// models/item.dart
import 'package:almasah_dates/features/purchaseOrder/data/models/goods.dart';

class PurchaseOrder {
  String? pOId;
  final String merchantName;
  List<Goods> goods;
  final String? date;
  final double totalPrice;
  final double remainAmount;
  String? notes;

  PurchaseOrder({
    this.pOId,
    required this.merchantName,
    required this.goods,
    this.date,
    required this.totalPrice,
    required this.remainAmount,
    this.notes,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => PurchaseOrder(
    pOId: json['poid'],
    merchantName: json['merchantName'],
    goods: (json['goods'] as List<dynamic>)
        .map((g) => Goods.fromJson(g))
        .toList(),
    date: json['date'],
    totalPrice: json['totalPrice'],
    remainAmount: json['remainAmount'],
    notes: json['notes'],
  );
  Map<String, dynamic> toJson() => {
    'poid': pOId,
    'merchantName': merchantName,
    'goods': goods.map((g) => g.toJson()).toList(),
    'date': date,
    'totalPrice': totalPrice,
    'remainAmount': remainAmount,
    'notes': notes,
  };
}
