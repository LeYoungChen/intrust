import 'package:intrust/HistoricPrice.dart';
import 'package:flutter/material.dart';

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

  Color get valueColour {
    if (priceDifference < 0) {
      return Color.fromRGBO(89, 211, 48, 1);
    }
    return Color.fromRGBO(220, 23, 17, 1);
  }

  Icon get priceChangeIcon {
    if (priceDifference < 0) {
      return Icon(
        Icons.arrow_drop_down,
        color: valueColour,
        size: 12,
      );
    }
    return Icon(
      Icons.arrow_drop_up,
      color: valueColour,
      size: 12,
    );
  }
}
