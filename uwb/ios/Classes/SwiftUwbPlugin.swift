import Flutter
import UIKit

@available(iOS 14.0, *)
public class SwiftUwbPlugin: NSObject, FlutterPlugin {
    static var channel: FlutterMethodChannel? = nil
    
    var niManager: NIManager = NIManager.shared
    var mpcManager: MPCManager = MPCManager()
    
    private override init() {
    }
      
    static public func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "uwb", binaryMessenger: registrar.messenger())
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
//            startLocationUpdates(arguments: "Testmessage")
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
    
    public func startLocationUpdates(arguments: String) {
        print("calling locationupdates: " + arguments)
        SwiftUwbPlugin.channel?.invokeMethod("updateLocation", arguments: arguments)
    }
}
