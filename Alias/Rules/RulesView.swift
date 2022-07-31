
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
        label.text = "УВЛЕКАТЕЛЬНАЯ КОМАНДНАЯ\nИГРА ДЛЯ ВЕСЁЛОЙ КОМПАНИИ"
        label.textColor = .white
        label.font = UIFont(name: "Piazzolla-Black", size: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [
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
    
    private lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: self.textRules)
        sv.axis = .vertical
        sv.spacing = 24.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        
//        let bgView = UIView()
//        bgView.backgroundColor = .white
//        sv.pinBackground(bgView)
        
        return sv
    }()
    
    private lazy var bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var containerScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self.contentStackView)
        
        return container
    }()
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            self.topStackView,
            self.bottomContainerView
        ])
        sv.axis = .vertical
        sv.spacing = 24.0
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        
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
        self.backgroundColor = UIColor(named: "RoyalBlueColor")
        
        self.addSubview(self.customNavigationBarStack)
        self.addSubview(self.containerScrollView)
        
        self.containerScrollView.addSubview(self.containerView)
        self.containerView.pin(to: self.containerScrollView)
        
        self.bottomContainerView.addSubview(self.bottomStackView)
        self.bottomStackView.pin(to: self.bottomContainerView, edges: .init(top: 30, left: 0, bottom: 16, right: 0))
        
        NSLayoutConstraint.activate([
            self.customNavigationBarStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.customNavigationBarStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            self.customNavigationBarStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            self.containerScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.containerScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.containerScrollView.topAnchor.constraint(equalTo: self.customNavigationBarStack.bottomAnchor, constant: 30),
            self.containerScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.containerScrollView.widthAnchor.constraint(equalTo: self.contentStackView.widthAnchor),
            
            self.aliasImageView.heightAnchor.constraint(equalToConstant: 64),
        ])
        
        self.contentStackView.pin(to: self.containerView)
    }
    
    @objc private func tapBackButton() {
        self.backStartMenuButtonTap?()
    }
}
