import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../util/battery_level.ts.dart';

part 'battery_level_event.dart';
part 'battery_level_state.dart';

class BatteryLevelBloc extends Bloc<BatteryLevelEvent, BatteryLevelState> {
  final BatteryLevelProvider _batteryLevelProvider = BatteryLevelProvider();
  BatteryLevelBloc() : super(const BatteryLevelInitial(-1)) {
    on <BatteryLevelStreamRequested>(_mapBatteryLevelStreamRequestedToState);
  }

  Future<void>  _mapBatteryLevelStreamRequestedToState(BatteryLevelStreamRequested event, Emitter<BatteryLevelState> emit) async {
    final Stream<int> batteryLevelStream = _batteryLevelProvider.getBatteryLevelStream();
    await emit.forEach(batteryLevelStream, onData: (int batteryLevel) {
      return BatteryLevelInitial(batteryLevel);
    });
    }
}
