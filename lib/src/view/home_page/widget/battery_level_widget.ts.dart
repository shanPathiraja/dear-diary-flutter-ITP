
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../initial_page/battery_level_bloc/battery_level_bloc.dart';

class BatteryLevel extends StatefulWidget {
  const BatteryLevel({super.key});

  @override
  State<StatefulWidget> createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) =>
    BatteryLevelBloc()
      ..add(BatteryLevelStreamRequested()),
        child: BlocBuilder<BatteryLevelBloc, BatteryLevelState>(
            builder: (context, state) {
              if (state.batteryLevel != -1) {
                return Text('Battery Level: ${state.batteryLevel}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),);
              }
              return const Text('Battery Level: Unknown',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            }));
  }
}