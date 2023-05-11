part of 'battery_level_cubit.dart';

@immutable
abstract class BatteryLevelState {
  const BatteryLevelState();
}

class BatteryLevelInitial extends BatteryLevelState {
  const BatteryLevelInitial();
}

class BatteryLevelLoading extends BatteryLevelState {
  const BatteryLevelLoading();
}

class BatteryLevelLoaded extends BatteryLevelState {
  final int batteryLevel;

  const BatteryLevelLoaded(this.batteryLevel);
}

class BatteryLevelError extends BatteryLevelState {
  final String message;

  const BatteryLevelError(this.message);
}
