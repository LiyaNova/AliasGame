
import UIKit

class StartMenuView: UIView {
    
    private lazy var aliasLabel: UILabel = {
        let label = UILabel()
        label.text = "ALIAS"
        label.textColor = .black
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var startGameButton: CustomButton = {
        let btn = CustomButton(color: .red, title: "Новая игра", buttonHandler: {
            [weak self] in
            print("press button startGameButton")
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private lazy var rulesButton: CustomButton = {
        let btn = CustomButton(color: .blue, title: "Правила", buttonHandler: {
            [weak self] in
            print("press button rulesButton")
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(self.aliasLabel)
        addSubview(self.startGameButton)
        addSubview(self.rulesButton)
        
        NSLayoutConstraint.activate([
            
            self.aliasLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            self.aliasLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            self.startGameButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            self.rulesButton.topAnchor.constraint(equalTo: self.startGameButton.bottomAnchor, constant: 20.0),
            
            self.rulesButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.rulesButton.bottomAnchor, constant: 100.0),
            self.rulesButton.widthAnchor.constraint(equalTo: self.startGameButton.widthAnchor),
            self.rulesButton.heightAnchor.constraint(equalTo: self.startGameButton.heightAnchor)
        ])
    }
}
