import 'package:intrust/dataclasses/Stock.dart';

class PriceWeightedIndex extends Stock {
  PriceWeightedIndex({
    this.name,
    this.value,
    this.priceDifference,
    this.pctPriceDifference
});

  final String name;
  final double value;
  final double priceDifference;
  final double pctPriceDifference;

  factory PriceWeightedIndex.fromJson(Map<String, dynamic> json) {
    return PriceWeightedIndex(
        name: json["name"] as String,
        value: json["value"] as double,
        priceDifference: json["priceDifference"] as double,
        pctPriceDifference: json["pctPriceDifference"] as double,
    );
  }
}