import 'package:intrust/HistoricPrice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stock {
  String name;
  String idNumber;
  double price;
  HistoricPrice get latestPrice => historicPrice.reduce((value, element) => value.date.isAfter(element.date) ? value : element);
  double get open => latestPrice.open;
  double get close => latestPrice.close;
  double get low => latestPrice.low;
  double get high => latestPrice.high;
  int get volume => latestPrice.volume;
  double get priceDifference => price - open;
  double get pctPriceDifference => priceDifference / open;
  List<HistoricPrice> historicPrice;

  Stock({
    this.name,
    this.idNumber,
    this.price,
    this.historicPrice
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    var hp = json["historic_price"] as List<Map<String, dynamic>>;
    List<HistoricPrice> listHistPrice;
    listHistPrice = hp.map<HistoricPrice>((json) => HistoricPrice.fromJson(json)).toList();
    return Stock(
        name: json["name"] as String,
        idNumber: json["no"] as String,
        price: json["price"] as double,
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

  String get compactVolume {
    return NumberFormat.compact().format(volume).toString();
  }
}
