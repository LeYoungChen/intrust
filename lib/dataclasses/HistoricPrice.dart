class HistoricPrice {
  DateTime date;
  double open;
  double close;
  double low;
  double high;
  int volume;

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
      date: DateTime.parse(json["date"]),
      open: json["open"] as double,
      close: json["close"] as double,
      low: json["low"] as double,
      high: json["high"] as double,
      volume: json["volume"] as int,
    );
  }
}