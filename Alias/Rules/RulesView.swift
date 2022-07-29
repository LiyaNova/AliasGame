
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
    
    private lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.text = "ПРАВИЛА"
        label.textColor = .white
        label.font = UIFont(name: "Phosphate-Solid", size: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var aliasImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Alias")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    //доделать лейбл с обводкой если останется время
//    private lazy var aliasLabel: UILabel = {
//        let label = UILabel()
//        label.text = "ALIAS"
//        label.accessibilityPath?.stroke()
//        label.textColor = UIColor(named: "OrangeColor")
//        label.font = UIFont(name: "Phosphate-Solid", size: 56.0)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
    //        let myAttributes: [NSAttributedString.Key: Any] = [
    //            .font: UIFont(name: "Phosphate-Solid", size: 56.0)!,
    //            .foregroundColor: UIColor.cyan,
    //            .strokeColor: UIColor.white,
    //            .strokeWidth: 5
    //        ]
    //        let myAttributedString = NSAttributedString(string: "ALIAS", attributes: myAttributes )
    //
    //        // Text layer
    //        let myTextLayer = CATextLayer()
    //        myTextLayer.string = myAttributedString
    //        myTextLayer.backgroundColor = UIColor.blue.cgColor
    //
    //
    //        myTextLayer.frame = .init(origin: .init(x: 50, y: 100), size: .init(width: 137, height: 130))
    //        self.layer.addSublayer(myTextLayer)
//        return label
//    }()
    
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
                                    self.ruleLabel,
                                    self.aliasImageView,
                                    self.textLabel
                                ])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 25
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var textRules: [CustomView] = {
        var views = [CustomView]()
        
        for (imageTitle, title) in zip(imageNamesArray, labelTextArray) {
            let view = CustomView(imageTitle: imageTitle, title: title)
            views.append(view)
        }
        return views
    }()
    
    private lazy var textRulesStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: textRules)
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
        
        return view
    }()
    
    
    private lazy var backButton: CustomButton = {
        let btn = CustomButton(color: .red, title: "Back") {
            [weak self] in
            guard let self = self else { return }
            self.backStartMenuButtonTap?()
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
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
        addSubview(self.textStackView)
        addSubview(self.whiteBackground)
        self.whiteBackground.addSubview(self.textRulesStackView)
        self.whiteBackground.addSubview(self.backButton)
        
        NSLayoutConstraint.activate([
            self.textStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            self.textStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -84.0),
            self.textStackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            self.aliasImageView.widthAnchor.constraint(equalToConstant: 147),
            self.aliasImageView.heightAnchor.constraint(equalToConstant: 64),
            
            self.textStackView.bottomAnchor.constraint(equalTo: self.whiteBackground.topAnchor, constant: -27.0),
            self.whiteBackground.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.whiteBackground.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: self.whiteBackground.bottomAnchor),
            
            
            self.textRulesStackView.topAnchor.constraint(equalTo: self.whiteBackground.topAnchor, constant: 32.0),
            self.textRulesStackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.textRulesStackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -32.0),
            
            
            self.backButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 30)
        ])
    }
}
