//
//  DifficultyPageView.swift
//  Alias
//
//  Created by Юлия Филимонова on 27.07.2022.
//

import UIKit

protocol TapButtonDelegate: AnyObject {
    func didBackChoice()
    func didForwardChoice()
    func didMakeChoice()
}

final class DifficultyPageView: UIView {

    weak var delegate: TapButtonDelegate?

    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .white
        titleLabel.text = "Уровень сложности"
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Phosphate-Solid", size: 24)
        titleLabel.textColor = .black
        return titleLabel
    }()

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
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Piazzolla-Medium", size: 16)
        return descriptionLabel
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

    private func setViews() {
        [titleLabel, backButton, choiceImageView, forwardButton,
         levelLabel, descriptionLabel, bottomButton].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),

            backButton.centerYAnchor.constraint(equalTo: choiceImageView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: choiceImageView.leadingAnchor, constant: 8),

            choiceImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 59),
            choiceImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            choiceImageView.widthAnchor.constraint(equalToConstant: 247),
            choiceImageView.heightAnchor.constraint(equalToConstant: 257),

            forwardButton.centerYAnchor.constraint(equalTo: choiceImageView.centerYAnchor),
            forwardButton.leadingAnchor.constraint(equalTo: choiceImageView.trailingAnchor, constant: -8),
            forwardButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -16),

            levelLabel.topAnchor.constraint(equalTo: choiceImageView.bottomAnchor, constant: 16),
            levelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 34),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 124),

            bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -11),
            bottomButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bottomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            bottomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            bottomButton.heightAnchor.constraint(equalToConstant: 66),
        ])
    }

}
