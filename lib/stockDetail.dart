import 'package:flutter/material.dart';
// import 'package:intrust/Stock.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';

class StockDetail extends StatefulWidget {
  @override
  _StockDetailState createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail>
    with TickerProviderStateMixin {
  TabController _tabController;
  List tabs = [
    '財務',
    '籌碼',
    '技術',
    '資訊',
    '新聞',
  ];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, 
      appBar: AppBar(
        backgroundColor: Colors.redAccent.withOpacity(1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text("公司名稱（代碼）"),
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(20), 
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 21),
                        blurRadius: 53,
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ], 
                  ), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: Column(
                          children: <Widget>[
                            OHLCVGraph(data: [
                              {
                                "open": 50.0,
                                "high": 100.0,
                                "low": 40.0,
                                "close": 80,
                                "volumeto": 0
                              },
                              {
                                "open": 80.0,
                                "high": 90.0,
                                "low": 55.0,
                                "close": 65,
                                "volumeto": 0
                              },
                              {
                                "open": 65.0,
                                "high": 120.0,
                                "low": 60.0,
                                "close": 90,
                                "volumeto": 0
                              },
                              {
                                "open": 90.0,
                                "high": 95.0,
                                "low": 85.0,
                                "close": 80,
                                "volumeto": 0
                              },
                              {
                                "open": 80.0,
                                "high": 85.0,
                                "low": 40.0,
                                "close": 50,
                                "volumeto": 0
                              },
                            ], enableGridLines: false, volumeProp: 0.2),
                          ],
                        ),
                      ),
                    ],
                  )),
              ], 
            ),
          ),
      ),
    );
  }
}
