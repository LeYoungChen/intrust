import 'package:flutter/material.dart';
import 'package:intrust/dataclasses/Strategy.dart';

class BackTest extends StatefulWidget {
  @override
  _BackTestState createState() => _BackTestState();
}

class Indicator extends StatelessWidget {
  Indicator({
    this.controller,
    this.itemCount: 0,
  }) : assert(controller != null);

  final PageController controller;

  final int itemCount;

  final Color normalColor = Color.fromRGBO(238, 238, 238, 1);

  final Color selectedColor = Color.fromRGBO(178, 178, 178, 1);

  final double size = 8.0;

  final double spacing = 4.0;

  Widget _buildIndicator(
      int index, int pageCount, double dotSize, double spacing) {
    // 是否被當前頁面選中
    bool isCurrentPageSelected = index ==
        (controller.page != null ? controller.page.round() % pageCount : 0);

    return new Container(
      height: size,
      width: size + (2 * spacing),
      child: new Center(
        child: new Material(
          color: isCurrentPageSelected ? selectedColor : normalColor,
          type: MaterialType.circle,
          child: new Container(
            width: dotSize,
            height: dotSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, (int index) {
        return _buildIndicator(index, itemCount, size, spacing);
      }),
    );
  }
}

class _BackTestState extends State<BackTest> {
  // fixme: this should not be hardcoded, suppose we are getting this from the database/api, too?
  List<Map<String, String>> hardcodedStrategies = [
    {
      "name": "投資策略#1",
      "description": "This is just some gibberish placeholder texts for description. "
    }, {
      "name": "投資策略#2",
      "description": "This is just some gibberish placeholder texts for description. "
    }, {
      "name": "投資策略#3",
      "description": "This is just some gibberish placeholder texts for description. "
    }, {
      "name": "投資策略#4",
      "description": "This is just some gibberish placeholder texts for description. "
    }, {
      "name": "投資策略#5",
      "description": "This is just some gibberish placeholder texts for description. "
    }
  ];

  List<Strategy> backTestStrategies;

  @override
  void initState() {
    super.initState();
    backTestStrategies =
        hardcodedStrategies.map<Strategy>((json) => new Strategy.fromJson(json)).toList();
  }

  String _selectedBackTest = "投資策略#1";

  final PageController controller = PageController(
      initialPage: 0
  );

  void _pageChanged(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('投資策略回測'),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0,),
            child: Center(
              child: new DropdownButton(
                items: backTestStrategies.map((backTestStrategy) =>
                      DropdownMenuItem(
                          child: Text(
                            backTestStrategy.name, 
                            style: TextStyle(
                              color: _selectedBackTest == backTestStrategy.name ? Colors.red : Colors.grey,
                            )
                          ),
                      value: backTestStrategy.name,
                      ),
                  ).toList(),
                hint: new Text("投資策略選擇",style: TextStyle(color: Colors.redAccent),),
                onChanged: (selectValue) {
                  setState(() {
                    _selectedBackTest = selectValue;
                  });
                },
                value: _selectedBackTest,
                elevation: 0,
                style: new TextStyle(color: Colors.redAccent, fontSize: 16),
                iconSize: 30,
                underline: Container(),
                isExpanded: true,
              ),
            ),
          ),
          Container(
            height: 500.0,
            child: PageView(
              controller: controller,
              children: <Widget>[
                Container(child: Text("投資策略回測資訊",
                  style: TextStyle(color: Colors.black,fontSize: 40),),),
                Container(child: Text("交易線圖及交易詳情",
                  style: TextStyle(color: Colors.black,fontSize: 40)),),
              ]
            ),
          ),
          Indicator(
            controller: controller,
            itemCount: 2,
          ),
        ],
      ),
    );
  }
}
