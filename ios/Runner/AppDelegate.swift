import UIKit
import Flutter
import DocereeAdSdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let channelName = "flutter.native/helper"
    var docereeAdChannel: FlutterMethodChannel?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        docereeAdChannel = FlutterMethodChannel(name: channelName,
                                                    binaryMessenger: controller as! FlutterBinaryMessenger)
        docereeAdChannel?.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "sendKey":
                print("appKey")
                if let args = call.arguments as? Dictionary<String, Any>, let appKey = args["appKey"] {
                    HcpManager().shared().sendAppKey(appKey: appKey as! String)
                    // please check the "as" above  - wasn't able to test
                    // handle the method
                    
                    result(nil)
                } else {
                }
            case "sendHcpData":
                HcpManager().shared().sendHcpProfile()
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        
        weak var registrar = self.registrar(forPlugin: "plugin-name")
        
        let factory = FLNativeViewFactory(messenger: registrar!.messenger())
        self.registrar(forPlugin: "<plugin-name>")!.register(
            factory,
            withId: "<platform-view-type>")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
    }
}
