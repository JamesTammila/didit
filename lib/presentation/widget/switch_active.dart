import 'package:flutter/material.dart';

class ActiveSwitch extends StatefulWidget {
  const ActiveSwitch({super.key});

  @override
  ActiveSwitchState createState() => ActiveSwitchState();
}

class ActiveSwitchState extends State<ActiveSwitch> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isActive,
      onChanged: (bool value) => setState(() {
        isActive = value;
      }),
    );
  }
}