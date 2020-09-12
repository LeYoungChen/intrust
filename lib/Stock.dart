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
}

class HistoricPrice {
  DateTime date;
  double open;
  double close;
  double low;
  double high;
  double volume;

  HistoricPrice({
    this.date,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  factory HistoricPrice.fromJson(Map<String, dynamic> json) {
    return HistoricPrice(
      date: DateTime.parse(json["date"]) as DateTime,
      open: json["open"] as double,
      close: json["close"] as double,
      low: json["low"] as double,
      high: json["high"] as double,
      volume: json["volume"] as double,
    );
  }
}
