part of 'battery_level_bloc.dart';

abstract class BatteryLevelState extends Equatable {

  final int batteryLevel;
  const BatteryLevelState(this.batteryLevel);

  @override
  List<Object> get props => [batteryLevel];
}

class BatteryLevelInitial extends BatteryLevelState {
  const BatteryLevelInitial(super.batteryLevel);

  @override
  List<Object> get props => [batteryLevel];
}
