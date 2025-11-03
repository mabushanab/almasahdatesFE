// models/item.dart

class Product {
  String itemName;
  double priceForItem;
  int quantity;
  double boxCost;
  int discount;
  String? notes;

  Product({
    required this.itemName,
    required this.priceForItem,
    required this.quantity,
    required this.boxCost,
    required this.discount,
    this.notes,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    itemName: json['itemName'],
    priceForItem: json['priceForItem'],
    quantity: json['quantity'],
    boxCost: json['boxCost'],
    discount: json['discount'],
    notes: json['notes'],
  );

  Map<String, dynamic> toJson() => {
    'itemName': itemName,
    'priceForItem': priceForItem,
    'quantity': quantity,
    'boxCost': boxCost,
    'discount': discount,
    'notes': notes,
  };
}
