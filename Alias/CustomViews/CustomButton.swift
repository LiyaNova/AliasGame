
import UIKit

class CustomButton: UIView {
    var buttonHandler: (() -> Void)?
    
    private var button = UIButton()

    init(color: UIColor, title: String, buttonHandler: @escaping () -> Void) {
        self.button = UIButton.makeButton(color: color, title: title)
        self.buttonHandler = buttonHandler
        
        super.init(frame: .zero)
        
        self.button.addTarget(self, action: #selector(self.keyPressed), for: .touchUpInside)
        
        setupView()
    }
    
    required init?(coder eCoder: NSCoder) {
        fatalError()
    }
    
    @objc private func keyPressed() {
        self.buttonHandler?()
    }
    
    private func setupView() {
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: self.button.bottomAnchor),
            self.button.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.button.trailingAnchor),
            
        ])
    }
}

private extension UIButton {
    
    static func makeButton(color: UIColor, title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.textColor = .white
        btn.backgroundColor = color
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 40.0)
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 15
        
        return btn
    }
}
