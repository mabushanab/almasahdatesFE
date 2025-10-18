// models/item.dart
class Item {
  final String name;
  final String type;

  Item({required this.name, required this.type});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json['name'],
        // price: (json['price'] as num).toDouble(),
        type: json['name'],
        // type: json['name'],

      );
}