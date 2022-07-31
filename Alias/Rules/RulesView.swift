
import UIKit

class RulesView: UIView {
    
    var backStartMenuButtonTap: (() -> Void)?
    private let imageNamesArray: [String] = ["Goodies Ok",
                                             "Goodies Nope",
                                             "Goodies Please",
                                             "Goodies Appreciation"
    ]
    
    private let labelTextArray: [String] = [
        "Задача каждого игрока - объяснить как можно больше слов товарищам по команде за ограниченное время.",
        "Во время объяснения нельзя использовать однокоренные слова, озвучивать перевод с иностранных языков.",
        "Отгаданное слово приносит команде одно очко, а за пропущенное слово команда штрафуется (в зависимости от настроек).",
        "Победителем становится команда, у которой количество очков достигло заранее установленного значения."
    ]
    
    private lazy var backButton: MyCustomBackButton = {
        let btn = MyCustomBackButton()
        btn.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.text = "ПРАВИЛА"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Phosphate-Solid", size: 24.0)
        
        return label
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
            self.backButton,
            self.ruleLabel,
            self.capView
        ])
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var aliasImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Alias")
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "УВЛЕКАТЕЛЬНАЯ КОМАНДНАЯ ИГРА ДЛЯ ВЕСЁЛОЙ КОМПАНИИ"
        label.textColor = .white
        label.font = UIFont(name: "Piazzolla-Black", size: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [
                                    self.customNavigationBarStack,
                                    self.aliasImageView,
                                    self.textLabel
                                ])
        sv.axis = .vertical
        sv.spacing = 25
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var textRules: [RuleDescriptionCustomView] = {
        var views = [RuleDescriptionCustomView]()
        
        for (imageTitle, title) in zip(self.imageNamesArray, self.labelTextArray) {
            let view = RuleDescriptionCustomView(imageTitle: imageTitle, title: title)
            views.append(view)
        }
        return views
    }()
    
    private lazy var textRulesStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: self.textRules)
        sv.axis = .vertical
        sv.spacing = 24.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        
        return sv
    }()
    
    private lazy var whiteBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.textRulesStackView)
        
        return view
    }()
    
    private lazy var containerStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.textStackView,
                                                self.whiteBackground
                                               ])
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    
    private lazy var myScroleView: UIScrollView = {
        let sv = UIScrollView()
        
        
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
     
        backgroundColor = UIColor(named: "RoyalBlueColor")
        addSubview(self.containerStackView)
        
        NSLayoutConstraint.activate([
            
            self.containerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.containerStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.containerStackView.trailingAnchor),
            self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.containerStackView.bottomAnchor),
            
            self.textStackView.topAnchor.constraint(equalTo: self.containerStackView.safeAreaLayoutGuide.topAnchor, constant: 35),
            self.textStackView.widthAnchor.constraint(equalTo: self.containerStackView.safeAreaLayoutGuide.widthAnchor, constant: -48.0),
            self.textStackView.centerXAnchor.constraint(equalTo: self.containerStackView.safeAreaLayoutGuide.centerXAnchor),
            self.textLabel.centerXAnchor.constraint(equalTo: self.containerStackView.centerXAnchor),
            
            self.aliasImageView.widthAnchor.constraint(equalToConstant: 147),
            self.aliasImageView.heightAnchor.constraint(equalToConstant: 64),
            
            self.textStackView.bottomAnchor.constraint(equalTo: self.containerStackView.topAnchor, constant: -27.0),
            self.whiteBackground.leadingAnchor.constraint(equalTo: self.containerStackView.safeAreaLayoutGuide.leadingAnchor),
            self.containerStackView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.whiteBackground.trailingAnchor),
            self.containerStackView.bottomAnchor.constraint(equalTo: self.whiteBackground.bottomAnchor),
            
            self.textRulesStackView.topAnchor.constraint(equalTo: self.whiteBackground.topAnchor, constant: 32.0),
            self.textRulesStackView.centerXAnchor.constraint(equalTo: self.whiteBackground.centerXAnchor),
            self.textRulesStackView.widthAnchor.constraint(equalTo: self.whiteBackground.widthAnchor, constant: -32.0),
        ])
    }
    
    @objc private func tapBackButton() {
        self.backStartMenuButtonTap?()
    }
}
