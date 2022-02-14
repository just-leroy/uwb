import Flutter
import UIKit

@available(iOS 14.0, *)
public class SwiftUwbPlugin: NSObject, FlutterPlugin {
    static var channel: FlutterMethodChannel?
    static var channel2: FlutterMethodChannel?
    
    var mpcManager: MPCManager = MPCManager()
    
    private override init() {
    }
      
    static public func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "uwb", binaryMessenger: registrar.messenger())
        channel2 = FlutterMethodChannel(name: "uwb2", binaryMessenger: registrar.messenger())
        let instance = SwiftUwbPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult)
    {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getTestMessage":
            result("This is a message from iOS")
        case "getSecondTestMessage":
            result("This is the second message")
        case "startLocationUpdates":
            print("started locationupdates")
//            SwiftUwbPlugin.startLocationUpdates(arguments: "Testmessage")
            result(true)
        case "startHostingProcess":
            print("started hosting")
            mpcManager.startAdvertising()
            result(true)
        case "startJoiningProcess":
            print("startedtojoin")
            mpcManager.sendInvite()
            result(true)
        default:
            result("Methodcall doesn't exist")
        }
    }
    
    static public func startLocationUpdates(arguments: String) {
        print("calling locationupdates: " + arguments)
//        SwiftUwbPlugin.channel?.invokeMethod("updateLocation", arguments: arguments)
        SwiftUwbPlugin.channel2?.invokeMethod("updateLocation", arguments: arguments)
    }
}
