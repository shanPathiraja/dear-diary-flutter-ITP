part of 'battery_level_bloc.dart';

class BatteryLevelState {
  int batteryLevel;

  BatteryLevelState({
    required this.batteryLevel,
  });

  static BatteryLevelState get initialState => BatteryLevelState(
        batteryLevel: -1,
      );

  BatteryLevelState clone({
    int? batteryLevel,
  }) {
    return BatteryLevelState(
      batteryLevel: batteryLevel ?? this.batteryLevel,
    );
  }
}
