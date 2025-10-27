// models/item.dart

class Goods {
   String itemName;
   double priceForGrams;
   double weightInGrams;
  String? notes;

  Goods({
    required this.itemName,
    required this.priceForGrams,
    required this.weightInGrams,
    this.notes,
  });

  factory Goods.fromJson(Map<String, dynamic> json) => Goods(
    itemName: json['itemName'],
    priceForGrams: json['priceForGrams'],
    weightInGrams: json['weightInGrams'],
    notes: json['notes'],
  );

  Map<String, dynamic> toJson() => {
    'itemName': itemName,
    'priceForGrams': priceForGrams,
    'weightInGrams': weightInGrams,
    'notes': notes,
  };
}
