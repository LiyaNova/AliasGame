
import UIKit

class CustomViewController: UIViewController {

    var nameViewControler: String { "" }
    
    lazy var customNavigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar(nameViewControler: nameViewControler, buttonHadler: popViewControler)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.customNavigationBarView)
        
        NSLayoutConstraint.activate([
            self.customNavigationBarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.customNavigationBarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.customNavigationBarView.trailingAnchor)
        ])
    }
    
    func popViewControler(){
        self.navigationController?.popViewController(animated: true)
    }
}
