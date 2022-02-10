package com.example.uwb

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** UwbPlugin */
class UwbPlugin: FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var eventChannel: EventChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "uwb")
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "locationStream")
    channel.setMethodCallHandler(this)
    eventChannel.setStreamHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        "getTestMessage" -> {
          result.success("You got a message from android!")
        }
        "getSecondTestMessage" -> {
          result.success("You got the second test message from android!")
        }
        "startLocationUpdates" -> {
          channel.invokeMethod("updateLocation", "TestMessage")
          result.success(true)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    TODO("Not yet implemented")

    //locatie updaten
    //object mappen
    //events.succes (nieuwe locatie)

    //in ios dictionary voor objects sturen. In kotlin een map.
    //object in object wordt map in map.
  }

  override fun onCancel(arguments: Any?) {
    TODO("Not yet implemented")
  }
}
