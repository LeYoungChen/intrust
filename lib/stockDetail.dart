import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/widgets/k_chart.dart';

class StockDetail extends StatefulWidget {
  final Stock stock;

  StockDetail({
    Key key,
    @required this.stock
  }) : super (key: key);

  @override
  _StockDetailState createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> with TickerProviderStateMixin {
  // fixme: ask Chuni, what to do with the mvAvg lines in week k-chart and month k-chart
  // fixme: wStockPrices and mSrockPrices need to be updated, currently taking the data for that date
  // fixme: wShares and mShares also need to be updated to be the sum of shares within that time range (also check with Chuni whether this is the right column LOL, shouldn't it be volume?)

  String selectedKChartRange = 'd';

  @override
  Widget build(BuildContext context) {

    Map<String, Widget> kCharts = <String, Widget>{
      'd': KChart(
        historicPrices: widget.stock.historicPrice,
        kChartRange: 'd',
      ),
      'w': KChart(
        historicPrices: widget.stock.historicPrice,
        kChartRange: 'w',
      ),
      'm': KChart(
        historicPrices: widget.stock.historicPrice,
        kChartRange: 'm',
      )
    };

    return Scaffold(
      resizeToAvoidBottomPadding: false, 
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 239, 242, 1.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(widget.stock.name + " (" + widget.stock.idNumber + ")"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // fixme: use Stack and Positioned to overlap the segmented control and the KChart
                // https://stackoverflow.com/questions/49838021/how-do-i-stack-widgets-overlapping-each-other-in-flutter
                // https://api.flutter.dev/flutter/widgets/Stack-class.html
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: CupertinoSlidingSegmentedControl(
                    groupValue: selectedKChartRange,
                    children: {
                      'd': Text(' D '),
                      'w': Text(' W '),
                      'm': Text(' M '),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        selectedKChartRange = value;
                      });
                    },
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 250,
                        width: double.infinity,
                        child: kCharts[selectedKChartRange]
                      ),
                    ],
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
