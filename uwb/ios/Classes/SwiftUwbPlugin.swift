import Flutter
import UIKit

public class SwiftUwbPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "uwb", binaryMessenger: registrar.messenger())
        let instance = SwiftUwbPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "getPlatformVersion") {
            result("iOS " + UIDevice.current.systemVersion)
        } else if (call.method == "getTestMessage") {
            result("This is a message from iOS")
        } else if (call.method == "getSecondTestMessage") {
            result("This is the second message")
        } else {
            result("Methodcall doesn't exist")
        }
    }
}
