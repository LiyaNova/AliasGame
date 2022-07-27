
import UIKit

class StartMenuView: UIView {
    
    var rulesMenuButtonTap: (() -> Void)?
    
    private lazy var aliasLabel: UILabel = {
        let label = UILabel()
        label.text = "ALIAS"
        label.textColor = .white
        label.font = UIFont(name: "Phosphate-Solid", size: 88)
        return label
    }()
    
    private lazy var startImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Goodies Awesome")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    private lazy var startGameButton: CustomButton = {
        let btn = CustomButton(color: .white, title: "Новая игра", buttonHandler: {
            [weak self] in
            guard let self = self else { return }
            print("tap start game button")
        })
        return btn
    }()
    
    private lazy var rulesButton: CustomButton = {
        let btn = CustomButton(color: .white, title: "Правила", buttonHandler: {
            [weak self] in
            guard let self = self else { return }
            self.rulesMenuButtonTap?()
        })
        return btn
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [
                                    self.startGameButton,
                                    self.rulesButton
                                ])
        sv.axis = .vertical
        sv.spacing = 16.0
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [
                                    self.aliasLabel,
                                    self.startImage,
                                    self.buttonStackView
                                ])
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 50.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor(named: "RoyalBlueColor")
        addSubview(self.contentStackView)
        
        NSLayoutConstraint.activate([
            self.contentStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            self.contentStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.contentStackView.bottomAnchor, constant: 20)
        ])
    }
}


