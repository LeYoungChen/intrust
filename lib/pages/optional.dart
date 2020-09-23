import 'package:flutter/material.dart';

class UserSelected extends StatefulWidget {
  @override
  _UserSelectedState createState() => _UserSelectedState();
}

class _UserSelectedState extends State<UserSelected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('自選股'),
      ),
    );
  }
}
