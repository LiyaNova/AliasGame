
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        window?.rootViewController = ResultScreenViewController(finalists: [Team(name: "dsfsd", scores: 0)])
        
        //AppNavigationController(rootViewController: ResultScreenViewController(finalists: [Team(name: "dsfsd", scores: 0)]))
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

