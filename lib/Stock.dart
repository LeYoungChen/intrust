import 'package:intrust/HistoricPrice.dart';

class Stock {
  String name;
  String idNumber;
  double openPrice;
  double currentPrice;
  double get priceDifference => currentPrice - openPrice;
  double get pctPriceDifference => priceDifference / openPrice;
  List<HistoricPrice> historicPrice;

  Stock({
    this.name,
    this.idNumber,
    this.openPrice,
    this.currentPrice,
    this.historicPrice
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    var hp = json["historic_price"] as List<Map<String, dynamic>>;
    List<HistoricPrice> listHistPrice;
    listHistPrice = hp.map<HistoricPrice>((json) => HistoricPrice.fromJson(json)).toList();
    return Stock(
        name: json["name"] as String,
        idNumber: json["no"] as String,
        openPrice: json["open"] as double,
        currentPrice: json["price"] as double,
        historicPrice: listHistPrice);
  }
}
