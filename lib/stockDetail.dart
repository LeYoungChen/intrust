import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intrust/HistoricPrice.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/widgets/k_chart.dart';

class StockDetail extends StatefulWidget {
  final Stock stock;

  StockDetail({Key key, @required this.stock}) : super(key: key);

  @override
  _StockDetailState createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: _buildAppBar(context, widget.stock),
        body: Column(
          children: <Widget>[
            AdditionalInformation(
              stock: widget.stock,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child:
                    kChartDisplay(historicPrices: widget.stock.historicPrice)),
          ],
        ));
  }
}

AppBar _buildAppBar(BuildContext context, Stock stock) {
  return AppBar(
    backgroundColor: Color.fromRGBO(238, 239, 242, 1.0),
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    elevation: 0,
    title: Text(
      stock.name,
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
  );
}

class AdditionalInformation extends StatefulWidget {
  final Stock stock;

  AdditionalInformation({
    Key key,
    this.stock,
  }) : super(key: key);

  @override
  _additionalInformationState createState() => _additionalInformationState();
}

class _additionalInformationState extends State<AdditionalInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(238, 239, 242, 1.0),
      width: double.infinity,
      height: 130.0,
      child: Column(
        children: <Widget>[
          Text(
            widget.stock.idNumber,
            style: TextStyle(
              color: Color.fromRGBO(151, 153, 154, 1),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(
            color: Color.fromRGBO(151, 153, 154, 1),
            height: 20,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.stock.price.toStringAsFixed(2),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                      Text(
                        widget.stock.priceDifference.toStringAsFixed(2) +
                            " (" +
                            widget.stock.pctPriceDifference.toStringAsFixed(2) +
                            "%)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: widget.stock.valueColour,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  width: 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "成交量",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                      Text(
                        widget.stock.compactVolume,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                const VerticalDivider(
                  color: Color.fromRGBO(151, 153, 154, 1),
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  width: 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "開",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                      Text(
                        widget.stock.open.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                const VerticalDivider(
                  color: Color.fromRGBO(151, 153, 154, 1),
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  width: 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "收",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                      Text(
                        widget.stock.close.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class kChartDisplay extends StatefulWidget {
  final List<HistoricPrice> historicPrices;

  kChartDisplay({Key key, @required this.historicPrices}) : super(key: key);

  @override
  _kChartDisplayState createState() => _kChartDisplayState();
}

class _kChartDisplayState extends State<kChartDisplay> {
  String selectedKChartRange = 'd';

  @override
  Widget build(BuildContext context) {
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
                        )),
                  ],
                )),
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
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
