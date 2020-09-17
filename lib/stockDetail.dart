import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intrust/HistoricPrice.dart';
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

  @override
  Widget build(BuildContext context) {

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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: kChartDisplay(historicPrices: widget.stock.historicPrice)
      ),
    );
  }
}

class kChartDisplay extends StatefulWidget {
  final List<HistoricPrice> historicPrices;

  kChartDisplay({
    Key key,
    @required this.historicPrices
  }) : super (key: key);

  @override
  _kChartDisplayState createState() => _kChartDisplayState();
}

class _kChartDisplayState extends State<kChartDisplay> {

  String selectedKChartRange = 'd';

  @override
  Widget build (BuildContext context) {

    Map<String, String> kChartRanges = <String, String>{
      'd': 'D',
      'w': 'W',
      'm': 'M',
    };
    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
      ),
      child: SingleChildScrollView(
        child: new Stack(
          children: <Widget>[
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
                        child: KChart(
                          historicPrices: widget.historicPrices,
                          kChartRange: kChartRanges[selectedKChartRange],
                        )
                    ),
                  ],
                )
            ),
            new Positioned(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: CupertinoSlidingSegmentedControl(
                    groupValue: selectedKChartRange,
                    children: {
                      'd': Text('D'),
                      'w': Text('W'),
                      'm': Text('M'),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        selectedKChartRange = value;
                      });
                    },
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
