import 'package:flutter/material.dart';
import 'package:intrust/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InTrust',
      theme: new ThemeData(
        primaryColor: Colors.white,
        accentColor: Color.fromRGBO(238, 238, 238, 1),
        indicatorColor: Color.fromRGBO(219, 61, 38, 1),
        appBarTheme: AppBarTheme(color: Color.fromRGBO(238, 238, 238, 1)),
        iconTheme: IconThemeData(color: Color.fromRGBO(186, 188, 189, 1)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'DIN2014',
      ),
      home: Home(),
    );
  }
}

