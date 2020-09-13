import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:intl/intl.dart';
import 'package:moving_average/moving_average.dart';
import 'package:intrust/Stock.dart';

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
    List<String> plottingDates() {
      if (kChartRange == 'd') {
        return historicPrices.map((hp) => dateFormat.format(hp.date)).toList();
      } else {
        List<DateTime> _allDates = List<DateTime>.generate(
            historicPrices.last.date
                .difference(historicPrices.first.date)
                .inDays, (i) =>
            historicPrices.first.date.add(Duration(days: i)));
        if (kChartRange == 'w') {
          List<DateTime> outputtingDateTime = _allDates.where((i) => i.weekday == DateTime.monday).toList();
          return outputtingDateTime.map((d) => dateFormat.format(d)).toList();
        }
        if (kChartRange == 'm') {
          List<DateTime> outputtingDateTime = _allDates.where((i) => i.day == 1).toList();
          return outputtingDateTime.map((d) => dateFormat.format(d)).toList();
        }
      }
    }

    List<String> dates = plottingDates();

    List<List<double>> plottingPrices() {
      if (kChartRange == 'd') {
        return historicPrices.map((hp) => [hp.open, hp.close, hp.low, hp.high]).toList();
      }
      else {
        List<DateTime> _allDates = List<DateTime>.generate(
            historicPrices.last.date
                .difference(historicPrices.first.date)
                .inDays, (i) =>
            historicPrices.first.date.add(Duration(days: i)));
        List<List<double>> _priceDetails = [];
        List<DateTime> _dates;
        List<HistoricPrice> _movingWindow;
        if (kChartRange == 'w') {
          _dates = _allDates.where((i) => i.weekday == DateTime.monday).toList();
        }
        if (kChartRange == 'm') {
          _dates = _allDates.where((i) => i.day == 1).toList();
        }

        for (int index = 0; index <= _dates.length - 1; index ++){
          if (index < _dates.length - 1) {
            _movingWindow = historicPrices.where((hp) => hp.date.isAfter(_dates[index]) && hp.date.isBefore(_dates[index+1])).toList();
          }
          else {
            _movingWindow = historicPrices.where((hp) => hp.date.isAfter(_dates[index])).toList();
          }
          if (_movingWindow.length > 0) {
            _movingWindow.sort((a, b) => a.date.compareTo(b.date));
            _priceDetails.add([
              _movingWindow.first.open,
              _movingWindow.last.close,
              _movingWindow.map((mv) => mv.low).toList().reduce((current, next) => current < next ? current : next),
              _movingWindow.map((mv) => mv.high).toList().reduce((current, next) => current > next ? current : next)
            ]);
          } else {
            dates.remove(dates[index]);
          }
        }
        assert(_priceDetails.length == dates.length);
        return _priceDetails;
      }
    }

    List<double> calculateMovingAverage(int nDay) {
      List<double> movingAvg = [];
      List<double> movingWindow = List<double>(nDay);
      for (int index = 1; index <= historicPrices.length; index++) {
        if (index < nDay) {
          movingAvg.add(null);
        } else {
          movingWindow = historicPrices.sublist(index-nDay, index).map((hp) => hp.close).toList();
          num sum = 0;
          movingWindow.forEach((num e){sum += e;});
          movingAvg.add(sum / movingWindow.length);
        }
      }
      assert(movingAvg.length == historicPrices.length);
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

//    List<double> calculateTotalShares(String range) {
//      List<double> movingAvg = [];
//      List<double> movingWindow;
//    }
//
//    List<double> plottingVolumes = calculateTotalShares('d');
    List<int> plottingVolumes = historicPrices.map((hp) => hp.volume).toList();
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
          data: ${dates}
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
            data: ${plottingPrices()}
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
            data: ${plottingVolumes}, 
            roundCap: true, 
            barWidth: '50%', 
          }
        ]
      }''',
    );
  }
}
