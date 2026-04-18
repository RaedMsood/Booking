// // import Flutter
// // import UIKit
// // import GoogleMaps // إضافة هذا السطر
// // import Firebase // أضف هذا السطر
// // @main
// // @objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
// //   override func application(
// //     _ application: UIApplication,
// //     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
// //   ) -> Bool {
// //   FirebaseApp.configure()
// //     // أضف مفتاح الخرائط هنا قبل السطر التالي
// //     GMSServices.provideAPIKey("AIzaSyCW3GVfviMCJBKNYTpIpwPrB8AUSwsrBKE")
// //
// //     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
// //   }
// //
// //   func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
// //     GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
// //   }
// // }
// import Flutter
// import UIKit
// import GoogleMaps
// import Firebase
// import UserNotifications
//
// @main
// @objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     FirebaseApp.configure()
//     GMSServices.provideAPIKey("AIzaSyCW3GVfviMCJBKNYTpIpwPrB8AUSwsrBKE")
//
//     UNUserNotificationCenter.current().delegate = self
//     application.registerForRemoteNotifications()
//
//
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
//
//   func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
//     GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
//   }
// }

import Flutter
import UIKit
import GoogleMaps
import Firebase
import FirebaseMessaging
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if FirebaseApp.app() == nil {
      FirebaseApp.configure()
    }
    if let mapsApiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String,
       !mapsApiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      GMSServices.provideAPIKey(mapsApiKey)
    } else {
      #if DEBUG
      print("[GoogleMaps] Missing GMSApiKey in Info.plist")
      #endif
    }

    UNUserNotificationCenter.current().delegate = self
    application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    #if DEBUG
    print("[APNS] Failed to register for remote notifications: \(error.localizedDescription)")
    #endif
    super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    if #available(iOS 14.0, *) {
      completionHandler([.banner, .list, .sound, .badge])
    } else {
      completionHandler([.alert, .sound, .badge])
    }
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}