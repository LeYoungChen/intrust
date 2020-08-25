import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:intrust/stockDetail.dart';

class KChart extends StatelessWidget {
  final List dates;
  final List prices;
  final List ma_5;
  final List ma_20;
  final List ma_60;
  const KChart({
    Key key,
    this.dates,
    this.prices,
    this.ma_5,
    this.ma_20,
    this.ma_60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Echarts(
      option: '''{
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            animation: false, 
            type: 'cross'
          }
        },
        legend: {
          data: ['K', '5MA', '20MA', '60MA']
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: ${dates}
        },
        yAxis: {
          scale: true
        },
        series: [
          {
            name: 'K', 
            type: 'k', 
            data: ${prices}
          },
          {
            name: '5MA',
            type: 'line',
            data: ${ma_5}
          },
          {
            name: '20MA',
            type: 'line',
            data: ${ma_20}
          },
          {
            name: '60MA',
            type: 'line',
            data: ${ma_60}
          }
        ]
      }''',
    );
  }
}
