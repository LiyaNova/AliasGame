import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupNavigationBar() {
        self.setNavigationBarHidden(true, animated: false)
    }
}

