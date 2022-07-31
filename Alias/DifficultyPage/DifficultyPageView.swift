
import UIKit

protocol TapButtonDelegate: AnyObject {
    func didBackChoice()
    func didForwardChoice()
    func didMakeChoice()
}

final class DifficultyPageView: UIView {
    
    weak var delegate: TapButtonDelegate?

    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        let image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return backButton
    }()

    @objc private func didTapBackButton() {
        self.delegate?.didBackChoice()
    }

    lazy var choiceImageView: UIImageView = {
        let choiceImageView = UIImageView()
        choiceImageView.translatesAutoresizingMaskIntoConstraints = false
        return choiceImageView
    }()

     private lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        forwardButton.setImage(image, for: .normal)
        forwardButton.tintColor = .black
        forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        return forwardButton
    }()

    @objc private func didTapForwardButton() {
        self.delegate?.didForwardChoice()
    }

    var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.backgroundColor = .white
        levelLabel.textAlignment = .center
        levelLabel.font = UIFont(name: "Phosphate-Solid", size: 32)
        return levelLabel
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.backgroundColor = .white
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Piazzolla", size: 16)
        return descriptionLabel
    }()

    var exampleLabel: UILabel = {
        let exampleLabel = UILabel()
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        exampleLabel.backgroundColor = .white
        exampleLabel.textColor = .black
        exampleLabel.numberOfLines = 0
        exampleLabel.lineBreakMode = .byWordWrapping
        exampleLabel.textAlignment = .center
        exampleLabel.font = UIFont(name: "Piazzolla", size: 16)
        return exampleLabel
    }()

     private lazy var bottomButton: UIButton = {
        let bottomButton = UIButton()
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.backgroundColor = .black
        bottomButton.setTitle("Далее", for: .normal)
        bottomButton.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        bottomButton.titleLabel?.textColor = .white
        bottomButton.layer.cornerRadius = 16
        bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return bottomButton
    }()

    @objc private func didTapBottomButton() {
        self.delegate?.didMakeChoice()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {[
        
//        self.titleLabel,
        self.backButton,
        self.choiceImageView,
        self.forwardButton,
        self.levelLabel,
        self.descriptionLabel,
        self.exampleLabel,
        self.bottomButton
    ].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
//            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.titleLabel.widthAnchor.constraint(equalToConstant: 150),

            self.backButton.centerYAnchor.constraint(equalTo: self.choiceImageView.centerYAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.backButton.trailingAnchor.constraint(equalTo: self.choiceImageView.leadingAnchor, constant: 8),

            choiceImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 59),
            choiceImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            choiceImageView.widthAnchor.constraint(equalToConstant: 247),
            choiceImageView.heightAnchor.constraint(equalToConstant: 257),

            self.forwardButton.centerYAnchor.constraint(equalTo: self.choiceImageView.centerYAnchor),
            self.forwardButton.leadingAnchor.constraint(equalTo: self.choiceImageView.trailingAnchor, constant: -8),
            self.forwardButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -16),

            self.levelLabel.topAnchor.constraint(equalTo: self.choiceImageView.bottomAnchor, constant: 16),
            self.levelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.descriptionLabel.topAnchor.constraint(equalTo: self.levelLabel.bottomAnchor, constant: 34),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.descriptionLabel.heightAnchor.constraint(equalToConstant: 60),

            self.exampleLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor,
                                                   constant: 5),
            self.exampleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.exampleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.exampleLabel.heightAnchor.constraint(equalToConstant: 60),

            self.bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -11),
            self.bottomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.bottomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.bottomButton.heightAnchor.constraint(equalToConstant: 66)
        ])
    }
    
}
