import UIKit
import Flutter
import Reachability

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "communicationStatus",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // This method is invoked on the UI thread.
        guard call.method == "getCommunicationStatus" else {
            result(FlutterMethodNotImplemented)
            return
          }
        let reachability = try! Reachability()
        switch reachability.connection {
        case .wifi:
            result("Wi-Fiに接続中")
        case .cellular:
            result("キャリアの回線に接続中")
        case .unavailable:
            result("インターネットに接続されていません")
        default:
            break
        }
      // Handle battery messages.
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
