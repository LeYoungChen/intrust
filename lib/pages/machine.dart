import 'package:flutter/material.dart';

class Machine extends StatefulWidget {
  @override
  _MachineState createState() => _MachineState();
}

class _MachineState extends State<Machine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('我的投資策略'),
      ),
    );
  }
}
