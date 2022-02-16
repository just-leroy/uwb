import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uwb/uwb.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Uwb _plugin = Uwb();
  String _location = "Null";
  String _platformVersion = 'Unknown';
  String _testMessage = 'Unclear';
  String _secondTestMessage = 'Undefined';
  bool? _locationStreamStarted = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onLocation(String location) {
    setState(() {
      _location = location;
      print("");
    });
  }

  Future<void> startLocationUpdates() async {
    try {
      _locationStreamStarted = await _plugin.startLocationUpdates(onLocation: onLocation)?? false;
    } on PlatformException {
      //TODO: throw exception
    }
  }

  Future<void> startHosting() async {
    try {
      _plugin.startHost;
      startLocationUpdates();
    } on PlatformException {
      //TODO: throw exception
    }
  }

  Future<void> joinHost() async {
    try {
      await _plugin.joinHost;
      startLocationUpdates();
    } on PlatformException {
      //TODO: throw exception
    }
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    String testMessage;
    String secondTestMessage;

    try {
      platformVersion =
          await _plugin.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      testMessage=
          await _plugin.getTestMessage?? 'Unknown test message';
    } on PlatformException {
      testMessage = 'Failed to get test message.';
    }

    try {
      secondTestMessage = await _plugin.getSecondTestMessage?? 'Second test message is unknown';
    } on PlatformException {
      secondTestMessage = 'Failed to get test message';
    }

    //get location stream
    //listen aanroepen op locationstream

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _testMessage = testMessage;
      _secondTestMessage = secondTestMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UWB example app'),
        ),
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('Test message: $_testMessage\n'),
              Text('Location stream started =  $_locationStreamStarted\n'),
              Text(_location),
              TextButton(onPressed: startHosting, child: Text('startHosting')),
              TextButton(onPressed: joinHost, child: Text('joinHost')),
              FloatingActionButton(onPressed: startLocationUpdates)
            ],
          )
        ),
      ),
    );
  }
}
