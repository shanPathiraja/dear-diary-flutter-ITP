import 'dart:async';

import 'package:flutter/material.dart';
import '../../util/battery_level.ts.dart';

class BatteryLevel extends StatefulWidget{
  const BatteryLevel({super.key});
  @override
  State<StatefulWidget> createState() => _BatteryLevelState();
}




class _BatteryLevelState extends State<BatteryLevel>{
  int batteryLevel = -1;
  @override
  void initState() {
    super.initState();

    Timer.periodic(
        const Duration(seconds: 10), (Timer t) => {
      getBatteryLevel().then((value) => {
        if(value != batteryLevel){
          setState((){
            batteryLevel = value;
          })
        }
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        batteryLevel == -1
            ? 'No Battery Data'
            : 'Battery: $batteryLevel %',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

}