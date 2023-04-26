import 'dart:async';

import 'package:flutter/material.dart';
import '../../util/battery_level.ts.dart';

class BatteryLevel extends StatefulWidget {
  const BatteryLevel({super.key});

  @override
  State<StatefulWidget> createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel> {
  int _batteryLevel = -1;
  final BatteryLevelProvider _batteryLevelProvider = BatteryLevelProvider();

  @override
  void initState() {
    super.initState();

    Timer.periodic(
        const Duration(seconds: 10),
        (Timer t) => {
             _batteryLevelProvider.getBatteryLevel().then((value) => {
                    if (value != _batteryLevel)
                      {
                        setState(() {
                          _batteryLevel = value;
                        })
                      }
                  })
            });
  }

  @override
  void dispose(){
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        _batteryLevel == -1 ? 'No Battery Data' : 'Battery: $_batteryLevel %',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
