import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:intl/intl.dart';
import 'package:intrust/HistoricPrice.dart';
import 'package:intrust/TimePeriod.dart';

class KChart extends StatelessWidget {
  final List<HistoricPrice> historicPrices;
  final String kChartRange;

  const KChart({
    Key key,
    this.historicPrices,
    this.kChartRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    historicPrices.sort((a, b) => a.date.compareTo(b.date));
    DateFormat dateFormat = DateFormat("\"yyyy-MM-dd\"");

    List<TimePeriod> breakDownByRange(Function toRangeName) {
      List<TimePeriod> _timePeriods = [];
      List<HistoricPrice> _inRange = [historicPrices[0]];
      String _currentRange = toRangeName(historicPrices[0].date);
      for (int index=1; index<historicPrices.length; index++) {
        if (toRangeName(historicPrices[index].date) != _currentRange) {
          _timePeriods.add(TimePeriod(
            name: _currentRange,
            dataInRange: _inRange,
          ));
          _currentRange = toRangeName(historicPrices[index].date);
          _inRange = [];
        }
        _inRange.add(historicPrices[index]);
      }
      return _timePeriods;
    }

    List<TimePeriod> determineDateRange() {
      if (kChartRange == 'D') {
        return historicPrices.map((hp) => TimePeriod(
          name: dateFormat.format(hp.date),
          dataInRange: [hp],
        )).toList();
      } else {
        if (kChartRange == 'W') {
          return breakDownByRange(weekNumber);
        } else {
          return breakDownByRange(monthNumber);
        }
      }
    }
    List<TimePeriod> kDateRange = determineDateRange();

    List<double> calculateMovingAverage(int nDay) {
      List<double> movingAvg = [];
      List<double> movingWindow = List<double>(nDay);
      List<DateTime> _firstDatesInRange =
          kDateRange.map((timePeriod) => timePeriod.firstDateInRange).toList();
      for (int index = 0; index < historicPrices.length; index++) {
        if (_firstDatesInRange.contains(historicPrices[index].date)) {
          if (index < nDay) {
            movingAvg.add(null);
          } else {
            movingWindow = historicPrices.sublist(index-nDay+1, index+1).map((hp) => hp.close).toList();
            num sum = 0;
            movingWindow.forEach((num e){sum += e;});
            movingAvg.add(sum / movingWindow.length);
          }
        }
      }
      assert(movingAvg.length == kDateRange.length);
      return movingAvg;
    }

    List<int> movingAvgLines;
    if (kChartRange == 'D') {
      movingAvgLines = [5, 20, 60];
    }
    if (kChartRange == 'W') {
      movingAvgLines = [10, 20, 60];
    }
    if (kChartRange == 'M') {
      movingAvgLines = [20, 60, 120];
    }

    return Echarts(
      option: '''{
        backgroundColor: 'rgba(241, 241, 241, 1)',
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            animation: false, 
            type: 'cross'
          }, 
          showContent: false
        },
        legend: {
          data: ['${movingAvgLines[0]}MA', '${movingAvgLines[1]}MA', '${movingAvgLines[2]}MA'],
          left: 'right'
        },
        grid: [{
          left: '10%',
          right: '8%',
          height: '40%',
        }, {
          left: '10%', 
          right: '8%', 
          top: '70%', 
          height: '10%'
        }],
        xAxis: [{
          type: 'category',
          boundaryGap: false,
          data: ${kDateRange.map((tp) => tp.name).toList()}, 
          axisLine: {onZero: false},
          splitLine: {show: false},
          axisTick: {show: false},
          axisLabel: {show: false},
        }, {
          type: 'category',
          gridIndex: 1,
          boundaryGap: false,
          data: ${kDateRange.map((tp) => tp.name).toList()}, 
          axisLine: {onZero: false},
          splitLine: {show: false},
          axisTick: {show: false},
        }],
        yAxis: [{
          scale: true, 
        }, {
          scale: true, 
          gridIndex: 1,
          axisTick: {
            show: false
          },
          axisLabel: {
            show: false
          }, 
          splitLine: {show: false}, 
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
          }, 
          bottom: 0, 
          height: 20, 
          minValueSpan: ${30 / movingAvgLines[0]}, 
          start: ${100 - 12 / kDateRange.length * 100}, 
          end: 100, 
          xAxisIndex: [0, 1]
        }, {
          type: 'inside'
        }],
        series: [
          {
            name: 'K', 
            type: 'k', 
            data: ${kDateRange.map((tp) => tp.getOpenCloseLowHigh).toList()}
          },
          {
            name: '${movingAvgLines[0]}MA',
            type: 'line',
            showSymbol: false, 
            data: ${calculateMovingAverage(movingAvgLines[0])}
          },
          {
            name: '${movingAvgLines[1]}MA',
            type: 'line',
            showSymbol: false, 
            data: ${calculateMovingAverage(movingAvgLines[1])}
          },
          {
            name: '${movingAvgLines[2]}MA',
            type: 'line',
            showSymbol: false, 
            data: ${calculateMovingAverage(movingAvgLines[2])}
          },
          {
            name: 'shares', 
            type: 'bar', 
            xAxisIndex: 1, 
            yAxisIndex: 1, 
            data: ${kDateRange.map((tp) => tp.totalVolume).toList()}, 
            roundCap: true, 
            barWidth: '50%', 
          }
        ]
      }''',
      extraScript: '''
        chart.on('click', (params) => {
          
        });
      ''',
    );
  }
}

String weekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  return "\"" +
      date.year.toString() +
      "WK" +
      ((dayOfYear - date.weekday + 10) / 7).floor().toString() +
      "\"";
}

String monthNumber(DateTime date) {
  return "\"" + date.year.toString() + "M" + date.month.toString() + "\"";
}
