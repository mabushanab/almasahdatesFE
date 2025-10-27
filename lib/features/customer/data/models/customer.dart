// models/item.dart
class Customer {
  final String name;
  final String type;
  final String mobileNumber;
  final String address;
  String? notes;
  int? rate;

  Customer({
    required this.name,
    required this.type,
    required this.address,
    required this.mobileNumber,
    this.notes,
     this.rate,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json['name'],
    // price: (json['price'] as num).toDouble(),
    type: json['type'],
    mobileNumber: json['mobileNumber'],
    address: json['address'],
    rate: json['rate'],
    notes: json['notes'],

    // type: json['name'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Customer && name == other.name;

  @override
  int get hashCode => name.hashCode;
  
}
