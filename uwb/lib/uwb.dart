import 'dart:async';
import 'package:flutter/services.dart';

class Uwb {
  late final Function(String) _onLocation;
  static const MethodChannel _channel = MethodChannel('uwb');
  static const EventChannel _eventChannel = EventChannel('locationStream');

  Uwb() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<bool?> startLocationUpdates({required Function(String) onLocation }) async {
    _onLocation = onLocation;
    final bool? startLocationUpdates = await _channel.invokeMethod('startLocationUpdates');
    return startLocationUpdates;
  }

  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<String?> get getTestMessage async {
    final String? testMessage = await _channel.invokeMethod('getTestMessage');
    return testMessage;
  }

  Future<String?> get getSecondTestMessage async {
    final String? secondTestMessage = await _channel.invokeMethod('getSecondTestMessage');
    return secondTestMessage;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch(call.method) {
      case "updateLocation":
        final String location = call.arguments;
        _onLocation(location);
        break;
      default:
        //TODO: throw exception
    }
  }

  static Future<Stream> get locationStream async {
    return _eventChannel.receiveBroadcastStream();
  }
}
// front facing api
// hier roep je de uwb platform interface aan.
