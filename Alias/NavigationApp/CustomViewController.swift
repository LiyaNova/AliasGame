
import UIKit

class CustomViewController: UIViewController {
    
    private lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var customBarButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4.0
        btn.backgroundColor = .white
        let configuration = UIImage.SymbolConfiguration(weight: .bold)
        
        
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 40.0),
            btn.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        return btn
    }()
    

    

    


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func setNavigationCustomTitle(_ title: String) {
        
    }
    
    func setNavigationCustomButton() {
    }
    
    
    @objc func popToViewController() {
        navigationController?.popViewController(animated: true)
    }
}
