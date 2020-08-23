import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

// import 'package:intrust/Stock.dart';

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

  List<Map<String, Object>> _sampleData2 = [{'date':'loading','shares':0,'open':0,'high':0,'low':0,'close':0,'5MA':0,'10MA':0,'20MA':0,'60MA':0,'120MA':0}];

  getRealData() async {
    await Future.delayed(Duration(seconds: 4));

    const realData = [
      {'date':'2020-05-05','shares':28103611,'open':40.45,'high':40.75,'low':38.9,'close':39.1,'5MA':38.51,'10MA':37.14,'20MA':35.9675,'60MA':36.4125,'120MA':41.5238},
      {'date':'2020-05-06','shares':18420314,'open':39.5,'high':39.9,'low':39.0,'close':39.25,'5MA':39.07,'10MA':37.495,'20MA':36.195,'60MA':36.3625,'120MA':41.4758},
      {'date':'2020-05-07','shares':39872828,'open':40.0,'high':41.4,'low':39.8,'close':41.0,'5MA':39.76,'10MA':38.025,'20MA':36.485,'60MA':36.3617,'120MA':41.4388},
      {'date':'2020-05-08','shares':32430111,'open':42.4,'high':42.5,'low':41.35,'close':41.55,'5MA':40.08,'10MA':38.645,'20MA':36.8625,'60MA':36.3917,'120MA':41.4192},
      {'date':'2020-05-11','shares':47553176,'open':42.9,'high':43.85,'low':42.25,'close':43.0,'5MA':40.78,'10MA':39.4,'20MA':37.3025,'60MA':36.4108,'120MA':41.4167},
      {'date':'2020-05-12','shares':48489846,'open':43.2,'high':44.55,'low':43.0,'close':44.25,'5MA':41.81,'10MA':40.16,'20MA':37.835,'60MA':36.405,'120MA':41.4129},
      {'date':'2020-05-13','shares':29574542,'open':44.2,'high':44.25,'low':43.55,'close':44.1,'5MA':42.78,'10MA':40.925,'20MA':38.295,'60MA':36.42,'120MA':41.3883},
      {'date':'2020-05-14','shares':45673024,'open':43.9,'high':44.55,'low':41.6,'close':41.95,'5MA':42.97,'10MA':41.365,'20MA':38.6675,'60MA':36.4008,'120MA':41.3204},
      {'date':'2020-05-15','shares':45488630,'open':43.0,'high':43.35,'low':41.2,'close':42.0,'5MA':43.06,'10MA':41.57,'20MA':39.0325,'60MA':36.38,'120MA':41.2463},
      {'date':'2020-05-18','shares':52581909,'open':40.8,'high':41.0,'low':38.15,'close':38.85,'5MA':42.23,'10MA':41.505,'20MA':39.205,'60MA':36.3092,'120MA':41.135},
      {'date':'2020-05-19','shares':40607901,'open':40.4,'high':40.8,'low':38.9,'close':39.3,'5MA':41.24,'10MA':41.525,'20MA':39.3325,'60MA':36.25,'120MA':41.0375},
      {'date':'2020-05-20','shares':25165201,'open':39.0,'high':39.8,'low':38.5,'close':39.15,'5MA':40.25,'10MA':41.515,'20MA':39.505,'60MA':36.1683,'120MA':40.9371},
      {'date':'2020-05-21','shares':44030064,'open':39.95,'high':41.35,'low':39.4,'close':41.3,'5MA':40.12,'10MA':41.545,'20MA':39.785,'60MA':36.1275,'120MA':40.8596},
      {'date':'2020-05-22','shares':30697478,'open':40.65,'high':40.85,'low':39.5,'close':39.6,'5MA':39.64,'10MA':41.35,'20MA':39.9975,'60MA':36.06,'120MA':40.7679},
      {'date':'2020-05-25','shares':26054660,'open':39.65,'high':40.35,'low':38.3,'close':40.15,'5MA':39.9,'10MA':41.065,'20MA':40.2325,'60MA':36.005,'120MA':40.69},
      {'date':'2020-05-26','shares':29246381,'open':40.45,'high':41.4,'low':40.05,'close':40.15,'5MA':40.07,'10MA':40.655,'20MA':40.4075,'60MA':35.985,'120MA':40.6121},
      {'date':'2020-05-27','shares':29402500,'open':40.5,'high':41.3,'low':40.4,'close':40.95,'5MA':40.43,'10MA':40.34,'20MA':40.6325,'60MA':36.0175,'120MA':40.54},
      {'date':'2020-05-28','shares':64183273,'open':41.7,'high':43.3,'low':41.65,'close':42.1,'5MA':40.59,'10MA':40.355,'20MA':40.86,'60MA':36.0692,'120MA':40.47},
      {'date':'2020-05-29','shares':23727329,'open':42.1,'high':42.5,'low':41.5,'close':42.0,'5MA':41.07,'10MA':40.355,'20MA':40.9625,'60MA':36.1075,'120MA':40.4033},
      {'date':'2020-06-01','shares':33127698,'open':42.3,'high':43.6,'low':42.2,'close':43.2,'5MA':41.68,'10MA':40.79,'20MA':41.1475,'60MA':36.1708,'120MA':40.3517},
      {'date':'2020-06-02','shares':41188127,'open':43.25,'high':44.1,'low':42.6,'close':43.2,'5MA':42.29,'10MA':41.18,'20MA':41.3525,'60MA':36.2142,'120MA':40.3037},
      {'date':'2020-06-03','shares':31380116,'open':44.05,'high':44.25,'low':43.35,'close':44.05,'5MA':42.91,'10MA':41.67,'20MA':41.5925,'60MA':36.2625,'120MA':40.255},
      {'date':'2020-06-04','shares':36814842,'open':44.75,'high':45.65,'low':44.3,'close':44.6,'5MA':43.41,'10MA':42.0,'20MA':41.7725,'60MA':36.3575,'120MA':40.2229},
      {'date':'2020-06-05','shares':24560394,'open':45.0,'high':45.35,'low':44.15,'close':44.25,'5MA':43.86,'10MA':42.465,'20MA':41.9075,'60MA':36.4492,'120MA':40.2008},
    ];

    this.setState(() { this._sampleData2 = realData; });
  }

  @override
  void initState() {
    super.initState();
    // get stock data
    this.getRealData();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List sampleData1 = [
      {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
      {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
      {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
      {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
      {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
      {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
      {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
      {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
      {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
      {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
      {"open":50.0, "high":100.0, "low":40.0, "close":80, "volumeto":5000.0},
      {"open":80.0, "high":90.0, "low":55.0, "close":65, "volumeto":4000.0},
      {"open":65.0, "high":120.0, "low":60.0, "close":90, "volumeto":7000.0},
      {"open":90.0, "high":95.0, "low":85.0, "close":80, "volumeto":2000.0},
      {"open":80.0, "high":85.0, "low":40.0, "close":50, "volumeto":3000.0},
    ];

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
        title: Text('公司名稱（代碼）'),
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
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
                        height: 180,
                        width: double.infinity,
                        child: new OHLCVGraph(
                          data: sampleData1,
                          enableGridLines: false,
                          volumeProp: 0.2
                        ),
                      ),
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
      ),
    );
  }
}
