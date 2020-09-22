import 'package:intrust/dataclasses/HistoricPrice.dart';

class TimePeriod {
  String name;
  List<HistoricPrice> dataInRange;

  TimePeriod({
    this.name,
    this.dataInRange,
  });

  DateTime get firstDateInRange {
    dataInRange.sort((a, b) => a.date.compareTo(b.date));
    return dataInRange.first.date;
  }

  List<double> get getOpenCloseLowHigh {
    dataInRange.sort((a, b) => a.date.compareTo(b.date));
    return [
      dataInRange.first.open,
      dataInRange.last.close,
      dataInRange
          .map((hp) => hp.low)
          .toList()
          .reduce((current, next) => current < next ? current : next),
      dataInRange
          .map((hp) => hp.high)
          .toList()
          .reduce((current, next) => current > next ? current : next),
    ];
  }

  int get totalVolume {
    return dataInRange.map((hp) => hp.volume).toList().reduce((value, element) => value + element);
  }
}
