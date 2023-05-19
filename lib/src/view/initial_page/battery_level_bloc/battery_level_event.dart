part of 'battery_level_bloc.dart';

abstract class BatteryLevelEvent extends Equatable {
  const BatteryLevelEvent();
}

class BatteryLevelStreamRequested extends BatteryLevelEvent {
  @override
  List<Object> get props => [];
}


