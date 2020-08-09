import 'package:flutter/material.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/stockDetail.dart';

class recommend extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<recommend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.withOpacity(1),
        elevation: 0,
        title: Text('我的推薦清單'),
      ),
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: <Widget>[
                    Stock(
                      title: "Stock#1",
                      price: 100.1,
                      priceDiff: 1.2,
                      pctDiff: 0.1,
                      indicator: "indicator",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return StockDetail();
                            },
                          ),
                        );
                      },
                    ),
                    Stock(
                      title: "Stock#2",
                      price: 99.9,
                      priceDiff: 1.2,
                      pctDiff: 0.9,
                      indicator: "indicator",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return StockDetail();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
