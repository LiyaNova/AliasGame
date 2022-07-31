
import UIKit

class CustomNavigationBar: UIView {
    var buttonHadler: (() -> Void)?
    var nameViewControler: String
    
    private lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = nameViewControler
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var customBarButton: MyCustomBackButton = {
        let btn = MyCustomBackButton()
        btn.addTarget(self, action: #selector(self.backButtonTap), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var capView: UIView = {
        let view = UIView()
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        return view
    }()
    
    private lazy var customNavigationBarStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            self.customBarButton,
            self.customTitleLabel,
            self.capView
        ])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    
    init(nameViewControler: String, buttonHadler: @escaping() -> Void) {
        self.nameViewControler = nameViewControler
        self.buttonHadler = buttonHadler
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backButtonTap() {
        self.buttonHadler?()
    }
    
    private func setupUI() {
        self.addSubview(self.customNavigationBarStack)
        
        NSLayoutConstraint.activate([
            self.customNavigationBarStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.customNavigationBarStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.trailingAnchor.constraint(equalTo: self.customNavigationBarStack.trailingAnchor, constant: 24),
            self.bottomAnchor.constraint(equalTo: self.customNavigationBarStack.bottomAnchor),
        ])
    }
}
