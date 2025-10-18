// models/item.dart
class Item {
  final int id;
  final String name;
  final double price;

  Item({required this.id, required this.name, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        price: (json['price'] as num).toDouble(),
      );
}