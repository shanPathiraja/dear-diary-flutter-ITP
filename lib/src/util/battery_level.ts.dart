import 'dart:developer';
import 'package:flutter/services.dart';

const platform = MethodChannel('com.example.dear_diary/battery');

Future<int> getBatteryLevel() async {
  int batteryLevel;
  try {
    final int result = await platform.invokeMethod('getBatteryLevel');
    batteryLevel = result;
  } on PlatformException catch (e) {
    batteryLevel = -1;
    log(e.toString());
  }
  return batteryLevel;
}
