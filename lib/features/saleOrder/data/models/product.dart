// models/item.dart

class Product {
   String itemName;
   double priceForItem;
   double quantity;
   double boxCost;
  String? notes;

  Product({
    required this.itemName,
    required this.priceForItem,
    required this.quantity,
    required this.boxCost,
    this.notes,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    itemName: json['itemName'],
    priceForItem: json['priceForItem'],
    quantity: json['quantity'],
    boxCost: json['boxCost'],
    notes: json['notes'],
  );

  Map<String, dynamic> toJson() => {
    'itemName': itemName,
    'priceForItem': priceForItem,
    'quantity': quantity,
    'boxCost': boxCost,
    'notes': notes,
  };
}
