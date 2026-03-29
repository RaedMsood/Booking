import Flutter
import UIKit
import GoogleMaps // إضافة هذا السطر

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // أضف مفتاح الخرائط هنا قبل السطر التالي
    GMSServices.provideAPIKey("AIzaSyCW3GVfviMCJBKNYTpIpwPrB8AUSwsrBKE")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
