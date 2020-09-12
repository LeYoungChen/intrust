import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:intl/intl.dart';
import 'package:intrust/Stock.dart';

class KChart extends StatelessWidget {
  final List<HistoricPrice> historicPrices;
  final List<dynamic> ma_5;
  final List<dynamic> ma_10;
  final List<dynamic> ma_20;
  final List<dynamic> ma_60;
  final List<dynamic> ma_120;
  final List<dynamic> shares;
  const KChart({
    Key key,
    this.historicPrices,
    this.ma_5,
    this.ma_10,
    this.ma_20,
    this.ma_60,
    this.ma_120,
    this.shares,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    historicPrices.sort((a, b) => a.date.compareTo(b.date));

    DateFormat dateFormat = DateFormat("\"yyyy-MM-dd\"");
    List<String> plottingDates = historicPrices.map((hp) => dateFormat.format(hp.date)).toList();

    List<List<double>> plottingPrices = historicPrices.map((hp) => [hp.open, hp.close, hp.low, hp.high]).toList();
    // fixme: datazoom is overlapping the main chart
    // fixme: datazoom default to recent month for day k-chart and last quarter for week k-chart and last year for month k-chart
    // fixme: ask chuni: volume/shares on a separate chart of overlay on the same chart?
    return Echarts(
      option: '''{
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            animation: false, 
            type: 'cross'
          }, 
          showContent: false
        },
        legend: {
          data: ['5MA', '20MA', '60MA'],
          left: 'right'
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
          data: ${plottingDates}
        },
        yAxis: [{
          scale: true
        }, {
          scale: true, 
          axisTick: {
            show: false
          },
          axisLabel: {
            show: false
          }, 
          boundaryGap: ['0%', '80%'], 
        }],
        dataZoom: [{
          textStyle: {
            color: '#8392A5'
          },
          handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
          handleSize: '80%',
          dataBackground: {
            areaStyle: {
              color: '#8392A5'
            },
            lineStyle: {
              opacity: 0.8,
              color: '#8392A5'
            }
          },
          handleStyle: {
            color: '#fff',
            shadowBlur: 3,
            shadowColor: 'rgba(0, 0, 0, 0.6)',
            shadowOffsetX: 2,
            shadowOffsetY: 2
          }
        }, {
          type: 'inside'
        }],
        series: [
          {
            name: 'K', 
            type: 'k', 
            data: ${plottingPrices}
          },
          {
            name: '5MA',
            type: 'line',
            showSymbol: false, 
            data: ${ma_5}
          },
          {
            name: '20MA',
            type: 'line',
            showSymbol: false, 
            data: ${ma_20}
          },
          {
            name: '60MA',
            type: 'line',
            showSymbol: false, 
            data: ${ma_60}
          },
          {
            name: 'shares', 
            type: 'bar', 
            yAxisIndex: 1, 
            data: ${shares}, 
            roundCap: true, 
            barWidth: '50%', 
          }
        ]
      }''',
    );
  }
}
