import 'dart:async';
import 'package:flutter/services.dart';

class Uwb {
  late final Function(String) _onLocation;
  late final Function(String) _connected;
  static const MethodChannel _channel = MethodChannel('uwb');
  static const MethodChannel _channel2 = MethodChannel('uwb2');
  static const EventChannel _eventChannel = EventChannel('locationStream');

  Uwb() {
    _channel2.setMethodCallHandler(_handleMethodCall);
  }

  Future<bool?> startLocationUpdates({required Function(String) onLocation }) async {
    _onLocation = onLocation;
    // final bool? startLocationUpdates = await _channel.invokeMethod('startLocationUpdates');
    return true;
  }

  Future<bool?> get startHost async {
    final bool? hostingProcess = await _channel.invokeMethod('startHostingProcess');
    return hostingProcess;
  }



  Future<bool?> get joinHost async {
    final bool? joiningProcess = await _channel.invokeMethod('startJoiningProcess');
    return joiningProcess;
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
    print("method called");
    switch(call.method) {
      case "updateLocation":
        print("received location update");
        final String location = call.arguments;
        print("Location: "+ call.arguments);
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
