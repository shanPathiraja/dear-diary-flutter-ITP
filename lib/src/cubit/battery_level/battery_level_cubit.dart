import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../util/battery_level.dart';

part 'battery_level_state.dart';

class BatteryLevelCubit extends Cubit<BatteryLevelState> {
  final BatteryLevelProvider _batteryLevelProvider = BatteryLevelProvider();

  BatteryLevelCubit() : super(const BatteryLevelInitial());

  Future<void> init() async {
    emit(const BatteryLevelLoading());
    try {
      final Stream<int> batteryLevelStream =
          _batteryLevelProvider.getBatteryLevelStream();
      batteryLevelStream.listen((int batteryLevel) {
        if (!_batteryLevelProvider.isDisposed) {
          emit(BatteryLevelLoaded(batteryLevel));
        }
      });
    } catch (e) {
      emit(BatteryLevelError(e.toString()));
    }
  }

  Future<void> getBatteryLevel() async {
    emit(const BatteryLevelLoading());
    final int batteryLevel = await _batteryLevelProvider.getBatteryLevel();
    emit(BatteryLevelLoaded(batteryLevel));
  }

  @override
  Future<void> close() {
    _batteryLevelProvider.dispose();
    return super.close();
  }
}
