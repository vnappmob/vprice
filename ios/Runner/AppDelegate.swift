import UIKit
import Flutter
import StoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SKStoreProductViewControllerDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let UserDefaultsChannel = FlutterMethodChannel(name: "vprice.vnappmob.com/UserDefaultsChannel",
                                                       binaryMessenger: controller.binaryMessenger)
        
        UserDefaultsChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "openProduct" {
                if let args = call.arguments as? [String: Any],
                   let appId = args["appId"] as? String {
                    self.displayProduct(viewController: controller, appId: Int(appId) ?? 0)
                    result(appId)
                } else {
                    result(FlutterError.init(code: "errorSetDebug", message: "data or format error", details: nil))
                }
            } else{
                result(FlutterMethodNotImplemented)
                return
            }
        })
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func displayProduct(viewController: UIViewController, appId: Int) {
        if appId != 0 {
            let parameters = [ SKStoreProductParameterITunesItemIdentifier : NSNumber(value:appId)]
            print(parameters)
            let storeViewController = SKStoreProductViewController()
            storeViewController.delegate = self
            storeViewController.loadProduct(withParameters: parameters) { (loaded, error) -> Void in
                print("loadProduct")
                if(error != nil) {
                    print("error")
                } else {
                    viewController.present(
                        storeViewController,
                        animated: true,
                        completion: {
                            print("Product Displayed...")
                        }
                    )
                }
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        print("productViewControllerDidFinish")
        viewController.dismiss(animated: true, completion: nil)
    }
}
