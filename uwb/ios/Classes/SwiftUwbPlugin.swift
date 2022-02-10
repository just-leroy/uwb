import Flutter
import UIKit

public class SwiftUwbPlugin: NSObject, FlutterPlugin {
    static var channel: FlutterMethodChannel? = nil
      
    static public func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "uwb", binaryMessenger: registrar.messenger())
        let instance = SwiftUwbPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "getPlatformVersion") {
            result("iOS " + UIDevice.current.systemVersion)
        } else if (call.method == "getTestMessage") {
            result("This is a message from iOS")
        } else if (call.method == "getSecondTestMessage") {
            result("This is the second message")
        } else if (call.method == "startLocationUpdates"){
            SwiftUwbPlugin.channel?.invokeMethod("updateLocation", arguments: "TestMessage")
            result(true)
        } else {
            result("Methodcall doesn't exist")
        }
    }
}
