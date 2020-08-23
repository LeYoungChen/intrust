import 'dart:convert';

import 'package:flutter/material.dart';
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
                        child: new Echarts(
                          option: '''{
                            tooltip: {
                              trigger: 'axis',
                              axisPointer: {
                                animation: false, 
                                type: 'cross'
                              }
                            },
                            legend: {
                              data: ['K', '5MA', '20MA', '60MA']
                            },
                            grid: {
                              left: '3%',
                              right: '4%',
                              bottom: '3%',
                              containLabel: true
                            },
                            xAxis: {
                              type: 'category',
                              boundaryGap: false,
                              data: ['2020-05-05','2020-05-06','2020-05-07','2020-05-08',
                              '2020-05-11','2020-05-12','2020-05-13','2020-05-14','2020-05-15',
                              '2020-05-18','2020-05-19','2020-05-20','2020-05-21','2020-05-22',
                              '2020-05-25','2020-05-26','2020-05-27','2020-05-28','2020-05-29',
                              '2020-06-01','2020-06-02','2020-06-03','2020-06-04','2020-06-05']
                            },
                            yAxis: {
                              scale: true
                            },
                            series: [
                              {
                                name: 'K', 
                                type: 'k', 
                                data: [
                                  [40.45,39.1,38.9,40.75],
                                  [39.5,39.25,39.0,39.9],
                                  [40.0,41.0,39.8,41.4],
                                  [42.4,41.55,41.35,42.5],
                                  [42.9,43.0,42.25,43.85],
                                  [43.2,44.25,43.0,44.55],
                                  [44.2,44.1,43.55,44.25],
                                  [43.9,41.95,41.6,44.55],
                                  [43.0,42.0,41.2,43.35],
                                  [40.8,38.85,38.15,41.0],
                                  [40.4,39.3,38.9,40.8],
                                  [39.0,39.15,38.5,39.8],
                                  [39.95,41.3,39.4,41.35],
                                  [40.65,39.6,39.5,40.85],
                                  [39.65,40.15,38.3,40.35],
                                  [40.45,40.15,40.05,41.4],
                                  [40.5,40.95,40.4,41.3],
                                  [41.7,42.1,41.65,43.3],
                                  [42.1,42.0,41.5,42.5],
                                  [42.3,43.2,42.2,43.6],
                                  [43.25,43.2,42.6,44.1],
                                  [44.05,44.05,43.35,44.25],
                                  [44.75,44.6,44.3,45.65],
                                  [45.0,44.25,44.15,45.35]
                                ]
                              },
                              {
                                name: '5MA',
                                type: 'line',
                                data: [38.51,39.07,39.76,40.08,
                                40.78,41.81,42.78,42.97,43.06,
                                42.23,41.24,40.25,40.12,39.64,
                                39.9,40.07,40.43,40.59,41.07,
                                41.68,42.29,42.91,43.41,43.86]
                              },
                              {
                                name: '20MA',
                                type: 'line',
                                data: [35.9675,36.195,36.485,36.8625,
                                37.3025,37.835,38.295,38.6675,39.0325,
                                39.205,39.3325,39.505,39.785,39.9975,
                                40.2325,40.4075,40.6325,40.86,40.9625,
                                41.1475,41.3525,41.5925,41.7725,41.9075]
                              },
                              {
                                name: '60MA',
                                type: 'line',
                                data: [36.4125,36.3625,36.3617,36.3917,
                                36.4108,36.405,36.42,36.4008,36.38,
                                36.3092,36.25,36.1683,36.1275,36.06,
                                36.005,35.985,36.0175,36.0692,36.1075,
                                36.1708,36.2142,36.2625,36.3575,36.4492]
                              }
                            ]
                          }''',
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
