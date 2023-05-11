
import 'package:dear_diary/src/cubit/battery_level/battery_level_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BatteryLevel extends StatefulWidget {
  const BatteryLevel({super.key});

  @override
  State<StatefulWidget> createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BatteryLevelCubit()..init(),
        child: BlocBuilder<BatteryLevelCubit, BatteryLevelState>(
            builder: (context, state) {
          if (state is BatteryLevelLoading) {
            return const CircularProgressIndicator();
          }
          if (state is BatteryLevelLoaded) {
            return Text(
              'Battery Level: ${state.batteryLevel}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          }
          return const Text(
            'Battery Level: Unknown',
            style: TextStyle(
              fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            }));
  }
}