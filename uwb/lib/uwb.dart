import 'dart:async';
import 'package:flutter/services.dart';

class Uwb {
  static const MethodChannel _channel = MethodChannel('uwb');
  static const EventChannel _eventChannel = EventChannel('locationStream');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get getTestMessage async {
    final String? testMessage = await _channel.invokeMethod('getTestMessage');
    return testMessage;
  }

  static Future<String?> get getSecondTestMessage async {
    final String? secondTestMessage = await _channel.invokeMethod('getSecondTestMessage');
    return secondTestMessage;
  }

  static Future<Stream> get locationStream async {
    return _eventChannel.receiveBroadcastStream();
  }
}


// front facing api
// hier roep je de uwb platform interface aan.
