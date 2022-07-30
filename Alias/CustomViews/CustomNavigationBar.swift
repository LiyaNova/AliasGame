
import UIKit

class CustomNavigationBar: UIView {

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
//        btn.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 40.0),
            btn.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        return btn
    }()
    
    
}
