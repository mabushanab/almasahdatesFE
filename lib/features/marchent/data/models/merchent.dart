// models/item.dart
class Merchant {
  final String name;
  final String type;
  final String mobileNumber;
  final String address;
  String? notes;
  int? rate;

  Merchant({
    required this.name,
    required this.type,
    required this.address,
    required this.mobileNumber,
    this.notes,
    this.rate,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    name: json['name'],
    // price: (json['price'] as num).toDouble(),
    type: json['type'],
    mobileNumber: json['mobileNumber'],
    address: json['address'],
    rate: json['rate'],
    notes: json['notes'],

    // type: json['name'],
  );
}
