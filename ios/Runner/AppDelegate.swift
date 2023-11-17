import Flutter
import UIKit
import flutter_background_service_ios

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"
    GeneratedPluginRegistrant.register(with: self)
      guard let controller: FlutterViewController = window?.rootViewController as? FlutterViewController else {
            fatalError("Invalid rootViewController")
        }
      methodChannel = FlutterMethodChannel(
      name: "com.myexample/test_channel",
      binaryMessenger: controller.binaryMessenger)
    setupMethodChannel()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    // In this function, we set up our methodchannel, such that we should be able to run
    // ```
    // const MethodChannel channel = MethodChannel('com.myexample/test_channel');
    // try {
    //   await channel.invokeMethod('test');         // -> "Hello from iOS"
    // } catch (e) {
    //   print(e);
    // }
    // ```
    // in our dart code.
    private func setupMethodChannel() {
    methodChannel?.setMethodCallHandler { (call, result) in
      switch call.method {
      case "test":
        result("Hello from iOS")
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
