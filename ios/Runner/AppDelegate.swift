import Flutter
import UIKit
import NaverThirdPartyLogin

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
      ) -> Bool {
        var applicationResult = false

        // Handle Naver login URL
        if (!applicationResult) {
           applicationResult = NaverThirdPartyLoginConnection
                              .getSharedInstance()
                              .application(app, open: url, options: options)
        }
        
        // Handle other URL schemes if any
        if (!applicationResult) {
           applicationResult = super.application(app, open: url, options: options)
        }
        
        return applicationResult
      }
}
