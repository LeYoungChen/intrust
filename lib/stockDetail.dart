import 'package:flutter/material.dart';
import 'package:intrust/Stock.dart';
import 'package:intrust/pages/recommend.dart';
import 'package:intrust/stock.dart';

class stockDetail extends StatefulWidget {
  @override
  _stockDetailState createState() => _stockDetailState();

}

class _stockDetailState extends State<stockDetail> with TickerProviderStateMixin{

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
      appBar: AppBar(
        backgroundColor: Colors.redAccent.withOpacity(1),
        elevation: 0,
        title: Text("公司名稱（代碼）"),
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
    );
  }
}
