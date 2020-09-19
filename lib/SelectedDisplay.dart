import 'package:flutter/material.dart';

class SelectedDisplay extends StatelessWidget {
  final String open;
  final String close;
  final String low;
  final String high;
  final String volume;
  final String movAvg_1;
  final String movAvg_2;
  final String movAvg_3;

  const SelectedDisplay({
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
    this.movAvg_1,
    this.movAvg_2,
    this.movAvg_3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("開"),
                Text(open)
              ],
            ),
            Column(
              children: <Widget>[
                Text("高"),
                Text(high)
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("收"),
                Text(close),
              ],
            ),
            Column(
              children: <Widget>[
                Text("低"),
                Text(low)
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("成交量"),
                Text(volume)
              ],
            ),
          ],
        ),
      ],
    );
  }
}