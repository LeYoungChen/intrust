import 'package:flutter/material.dart';
import 'package:intrust/pages/recommend.dart';
import 'package:intrust/pages/optional.dart';
import 'package:intrust/pages/userPage.dart';
import 'package:intrust/pages/backtest.dart';
import 'package:intrust/pages/machine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Recommended(),
    UserSelected(),
    UserPage(),
    BackTest(),
    Machine(),
  ]; // to store tab views

  Widget currentScreen = Recommended(); // initial pages

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        backgroundColor: Theme.of(context).accentColor,
        tabBar: CupertinoTabBar(
          activeColor: Theme.of(context).indicatorColor,
          inactiveColor: Theme.of(context).iconTheme.color,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Octicons.bookmark), title: Text("推薦")),
            BottomNavigationBarItem(
                icon: Icon(Octicons.list_unordered), title: Text("自選")),
            BottomNavigationBarItem(
                icon: Image(
                  // fixme: to be replaced with icon without background
                  image: AssetImage('assets/images/logo_icon.png')), title: Text("InTrust")),
            BottomNavigationBarItem(
                icon: Icon(Octicons.graph), title: Text("迴測")),
            BottomNavigationBarItem(
                icon: Icon(Octicons.device_desktop), title: Text("機器股"))
          ],
          currentIndex: currentTab,
          onTap: (int index) {
            setState(() {
              currentTab = index;
            });
          },
        ),
        resizeToAvoidBottomInset: false,
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return screens[index];
            },
          );
        });
  }
}
