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
      if (kChartRange == 'd') {
        return historicPrices.map((hp) => TimePeriod(
          name: dateFormat.format(hp.date),
          dataInRange: [hp],
        )).toList();
      } else {
        if (kChartRange == 'w') {
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
    if (kChartRange == 'd') {
      movingAvgLines = [5, 20, 60];
    }
    if (kChartRange == 'w') {
      movingAvgLines = [10, 20, 60];
    }
    if (kChartRange == 'm') {
      movingAvgLines = [20, 60, 120];
    }

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
          data: ['${movingAvgLines[0]}MA', '${movingAvgLines[1]}MA', '${movingAvgLines[2]}MA'],
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
          data: ${kDateRange.map((tp) => tp.name).toList()}
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
            yAxisIndex: 1, 
            data: ${kDateRange.map((tp) => tp.totalVolume).toList()}, 
            roundCap: true, 
            barWidth: '50%', 
          }
        ]
      }''',
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
