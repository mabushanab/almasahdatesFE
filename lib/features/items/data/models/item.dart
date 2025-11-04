// models/item.dart
class Item {
  final String name;
  final String type;
  String? subType;
  final double salePrice;

  Item({required this.name, required this.type, required this.subType,
  required this.salePrice});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json['name'],
    type: json['type'],
    subType: json['subType'],
    salePrice: json['salePrice'] as double

  );

    Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'subType': subType,
    'salePrice': salePrice,
  };
}
