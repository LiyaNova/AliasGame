
import UIKit

class CustomViewController: UIViewController {
    

    
    private lazy var customNavigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    @objc func backButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
