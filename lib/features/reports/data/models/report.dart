class Report {
  double sumPO;
  double sumPORemain;
  double sumSO;
  double sumSORemain;
  Map<String, double> avgProductPrice;
  Map<String, double> avgGoodPrice;
  Map<String, double> avgProductPriceWithBox;
  Map<String, double> avgProfitPerItem;
  Map<String, double> totalProfitPerItem;

  Report({
    required this.sumPO,
    required this.sumPORemain,
    required this.sumSO,
    required this.sumSORemain,
    required this.avgProductPrice,
    required this.avgGoodPrice,
    required this.avgProductPriceWithBox,
    required this.avgProfitPerItem,
    required this.totalProfitPerItem,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    sumPO: (json['sumPO'] as num).toDouble(),
    sumPORemain: (json['sumPORemain'] as num).toDouble(),
    sumSO: (json['sumSO'] as num).toDouble(),
    sumSORemain: (json['sumSORemain'] as num).toDouble(),
    avgProductPrice: Map<String, double>.from(
      (json['avgProductPrice'] as Map).map(
        (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
      ),
    ),
    avgGoodPrice: Map<String, double>.from(
      (json['avgGoodPrice'] as Map).map(
        (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
      ),
    ),
    avgProductPriceWithBox: Map<String, double>.from(
      (json['avgProductPriceWithBox'] as Map).map(
        (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
      ),
    ),
    avgProfitPerItem: Map<String, double>.from(
      (json['avgProfitPerItem'] as Map).map(
        (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
      ),
    ),
    totalProfitPerItem: Map<String, double>.from(
      (json['totalProfitPerItem'] as Map).map(
        (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
      ),
    ),
  );
}
