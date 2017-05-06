import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isFirstTimeLaunched:Bool {
        return UserDefaults.standard.value(forKey: "FirstTimeLaunched") as? Bool ?? true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if isFirstTimeLaunched {
            print("FIRST TIME LAUNCHED")
            UserDefaults.standard.set(false, forKey: "FirstTimeLaunched")
        } else {
            print("This is not the first time launched")
        }
        
        return true
    }
}

