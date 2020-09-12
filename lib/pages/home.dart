import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intrust/pages/recommend.dart';
import 'package:intrust/pages/optional.dart';
import 'package:intrust/pages/backtest.dart';
import 'package:intrust/pages/machine.dart';


import 'recommend.dart';
import 'optional.dart';
import 'backtest.dart';
import 'machine.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  // Properties

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Recommended(),
    optional(),
    backtest(),
    machine(),
  ]; // to store tab views

  Widget currentScreen = Recommended(); // initial pages

  final PageStorageBucket bucket = PageStorageBucket();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      // FAB Button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: (){
        },
      ),

      // FAB positioning
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom tabs
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0.2,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = Recommended();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(
                        Icons.format_line_spacing,
                        color: currentTab == 0 ? Colors.redAccent : Colors.grey,),
                      Text(
                        '推薦',
                        style: TextStyle(
                          color: currentTab == 0 ? Colors.redAccent : Colors.grey, ),)
                    ],),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = optional();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(
                        Icons.offline_pin,
                        color: currentTab == 1 ? Colors.redAccent : Colors.grey,),
                      Text(
                        '自選',
                        style: TextStyle(
                          color: currentTab == 1 ? Colors.redAccent : Colors.grey, ),)
                    ],),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = backtest();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.replay,
                          color: currentTab == 2 ? Colors.redAccent : Colors.grey,),
                        Text(
                          '回測',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.redAccent : Colors.grey, ),)
                      ],),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = machine();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.android,
                          color: currentTab == 3 ? Colors.redAccent : Colors.grey,),
                        Text(
                          '機器股',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.redAccent : Colors.grey, ),)
                      ],),
                  ),
                ],
              )

            ],
          ),
        ),
      ),

    );

  }
}
