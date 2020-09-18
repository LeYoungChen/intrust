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
            BasicInformation(
              stock: widget.stock,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child:
                    kChartDisplay(historicPrices: widget.stock.historicPrice)
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: AdditionalInformation(stock: widget.stock)
            ),
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

class BasicInformation extends StatefulWidget {
  final Stock stock;

  BasicInformation({
    Key key,
    this.stock,
  }) : super(key: key);

  @override
  _basicInformationState createState() => _basicInformationState(
    open: stock.open.toStringAsFixed(2),
    close: stock.close.toStringAsFixed(2),
    low: stock.low.toStringAsFixed(2),
    high: stock.high.toStringAsFixed(2),
    volume: stock.compactVolume,
  );
}

class _basicInformationState extends State<BasicInformation> {
  String open;
  String close;
  String low;
  String high;
  String volume;

  _basicInformationState({
    Key key,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

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
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        volume,
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
                        "高",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        high,
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
                        "低",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        low,
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
                  color: Color.fromRGBO(241, 241, 241, 1),
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

class AdditionalInformation extends StatefulWidget {
  final Stock stock;

  AdditionalInformation({Key key, @required this.stock}) : super(key: key);

  @override
  _AdditionalInformationState createState() => _AdditionalInformationState();
}

class _AdditionalInformationState extends State<AdditionalInformation> {

  String selectedTab = 'financial';

  Widget financialHeatMap() {

    Widget heatmapUnit(String text, num value) {
      Color heatColour;
      if (value == null) {
        heatColour = Color.fromRGBO(241, 241, 241, 1);
      } else if (value > 0.15) {
        heatColour = Color.fromRGBO(225, 48, 34, 1);
      } else if (value > 0.1) {
        heatColour = Color.fromRGBO(240, 148, 142, 1);
      } else if (value > 0.05) {
        heatColour = Color.fromRGBO(242, 213, 213, 1);
      } else if (value < -0.15) {
        heatColour = Color.fromRGBO(136, 199, 60, 1);
      } else if (value < -0.1) {
        heatColour = Color.fromRGBO(166, 226, 102, 1);
      } else if (value < -0.05) {
        heatColour = Color.fromRGBO(199, 229, 151, 1);
      } else {
        heatColour = Color.fromRGBO(196, 196, 196, 1);
      }

      return SizedBox(
        width: 60,
        height: 40,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: heatColour,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),),
      );
    }

    SizedBox spacing = SizedBox(height: 5, width: 5,);

    return Container(
      child: Row(children: <Widget>[
        Column(
          children: <Widget>[
            heatmapUnit("指標", null),
            spacing,
            heatmapUnit("PEG", null),
            spacing,
            heatmapUnit("CFER", null),
            spacing,
            heatmapUnit("GVI", null),
            spacing,
            heatmapUnit("Debt Ratio", null),
          ],
        ),
        spacing,
        Column(
          children: <Widget>[
            heatmapUnit("去年", null),
            spacing,
            heatmapUnit("", 0.07),
            spacing,
            heatmapUnit("", 0.07),
            spacing,
            heatmapUnit("", -0.12),
            spacing,
            heatmapUnit("", 0),
          ],
        ),
        spacing,
        Column(
          children: <Widget>[
            heatmapUnit("今年", null),
            spacing,
            heatmapUnit("", 0.07),
            spacing,
            heatmapUnit("", 0.07),
            spacing,
            heatmapUnit("", 0),
            spacing,
            heatmapUnit("", -0.17),
          ],
        ),
        spacing,
        Column(
          children: <Widget>[
            heatmapUnit("上個月", null),
            spacing,
            heatmapUnit("", 0.12),
            spacing,
            heatmapUnit("", 0.17),
            spacing,
            heatmapUnit("", -0.07),
            spacing,
            heatmapUnit("", 0),
          ],
        ),
        spacing,
        Column(
          children: <Widget>[
            heatmapUnit("這個月", null),
            spacing,
            heatmapUnit("", 0.17),
            spacing,
            heatmapUnit("", 0.12),
            spacing,
            heatmapUnit("", -0.17),
            spacing,
            heatmapUnit("", 0.07),
          ],
        ),
      ],),
    );
  }
  
  Widget button(String tabKey, String title) {

    Color buttonColour;
    Color textColour;
    if (tabKey == selectedTab) {
      buttonColour = Color.fromRGBO(225, 48, 34, 1);
      textColour = Colors.white;
    } else {
      buttonColour = Color.fromRGBO(250, 250, 250, 1);
      textColour = Colors.black;
    }

    return
      ButtonTheme(
        minWidth: 55,
        height: 30,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: buttonColour)),
          onPressed: () {
            setState(() {
              selectedTab = tabKey;
            });
          },
          color: buttonColour,
          textColor: textColour,
          child: Text(title, style: TextStyle(fontSize: 12)),
        ));
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, Widget> subTabs = {
      'financial': financialHeatMap(),
      'chip': Container(child: Text('chip'),),
      'technical': Container(child: Text('technical'),),
      'sector_information': Container(child: Text('sector_information'),),
      'news': Container(child: Text('news'),),
    };

    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(241, 241, 241, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(left: 15, right: 5, bottom: 15),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              button('financial', '財務'),
              SizedBox(width: 10, ),
              button('chip', '籌碼'),
              SizedBox(width: 10, ),
              button('technical', '技術'),
              SizedBox(width: 10, ),
              button('sector_information', '產業資訊'),
              SizedBox(width: 10, ),
              button('news', '新聞'),
            ],
          ),
          subTabs[selectedTab]
        ],
      )
    );
  }
}
