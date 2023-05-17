import 'dart:developer';

import 'package:flutter/services.dart';

class BatteryLevelProvider {
  MethodChannel platform =
      const MethodChannel('com.example.dear_diary/battery');
  bool _isDisposed = false;

  Future<int> getBatteryLevel() async {
    int batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = result;
    } on PlatformException catch (e) {
      batteryLevel = -1;
      log(e.toString());
      throw Exception(e);
    }
    return batteryLevel;
  }

  Stream<int> getBatteryLevelStream() async* {
    int batteryLevel = -1;
    while (!_isDisposed) {
      try {
        batteryLevel = await getBatteryLevel();
        // log('Battery Level: $batteryLevel');
      } on PlatformException catch (e) {
        batteryLevel = -1;
        log(e.toString());
        throw Exception(e);
      }
      yield batteryLevel;
      await Future.delayed(const Duration(seconds: 5), () {});
    }
  }

  bool get isDisposed => _isDisposed;

  void dispose() {
    platform.setMethodCallHandler(null);
    _isDisposed = true;
  }
}
