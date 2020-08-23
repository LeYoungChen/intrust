import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:intrust/stockDetail.dart'; 

class KChart extends State<StockDetail> {
  List<Map<String, Object>> _priceData = [{
    'date': 'pulling...', 
    'open': 0, 
    'close': 0,
    'high': 0, 
    'low': 0
  }]; 

  getData() async {
    await Future.delayed(Duration(seconds: 4)); 

    const priceDataObj = [{
      'date': '2020-08-03', 
      'open': 100.0, 
      'close': 101.1, 
      'high': 101.9, 
      'low': 99.3
    }, {
      'date': '2020-08-04', 
      'open': 101.1, 
      'close': 101.5, 
      'high': 102.5, 
      'low': 99.9
    }, {
      'date': '2020-08-05', 
      'open': 101.5, 
      'close': 100.9, 
      'high': 101.7, 
      'low': 100.1
    }, {
      'date': '2020-08-06', 
      'open': 100.9, 
      'close': 101.7, 
      'high': 101.7, 
      'low': 100.2
    }, {
      'date': '2020-08-07', 
      'open': 101.7, 
      'close': 102.2, 
      'high': 102.8, 
      'low': 100.6
    }];

    this.setState(() { this._priceData = priceDataObj; });
  }

  @override
  void initState() {
    super.initState(); 
    this.getData(); 
  }

  @override
  Widget build(BuildContext context) {
    return Echarts(
      option: 
      '''
      {
        xAxis: {
          type: 'time', 
          dataset: , 
        }
      }
      ''', 
    );
  }
}
