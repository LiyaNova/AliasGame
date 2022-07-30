import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.setNavigationBarHidden(true, animated: false)
    }
}

