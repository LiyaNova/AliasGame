//
//  GameScreenView.swift
//  Alias
//
//  Created by Alex Ch. on 27.07.2022.
//

import UIKit

class GameScreenView: UIView {
    
    // MARK: - UI elements
    
    // Лейбл с секундами
    private lazy var secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "27"
        label.textColor = .black
        label.font = UIFont(name: "PhosphateRR Solid", size: 72)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Лейбл с текстом о секундах
    private lazy var secondsTextLabel: UILabel = {
        let label = UILabel()
        label.text = "секунд"
        label.textColor = .black
        label.font = UIFont(name: "Phosphate", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Лейбл с игровым словом
    private lazy var gameWodrLabel: UILabel = {
        let label = UILabel()
        label.text = "ОТРАЖЕНИЕ"
        label.textColor = .black
        label.font = UIFont(name: "Phosphate", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Картинка карточки (игровое поле)
    private lazy var gameImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Carts"))
        image.addSubview(gameWodrLabel)
        return image
    }()
    
    // Кнопка правильного ответа
    private var rightButton = UIButton()
    private lazy var rightAnswerBtn: UIButton = {
        rightButton = makeButton(color: .green, image: "Ok")
        rightButton.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        return rightButton
    }()
    
    // Кнопка неправильного ответа
    private var wrongButton = UIButton()
    private lazy var wrongAnswerBtn: UIButton = {
        wrongButton = makeButton(color: .red, image: "WrongAnswer")
        wrongButton.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        return wrongButton
    }()
    
    // Стэк для секунд
    private lazy var secondsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.secondsLabel, self.secondsTextLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    // Стэк для кнопок
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.wrongAnswerBtn, self.rightAnswerBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 40
        return stack
    }()
    
    // Стэк общий
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.secondsStack, self.gameImage, self.buttonsStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func rightAnswer(){
        print("Right!")
    }
    
    @objc private func wrongAnswer(){
        print("Wrong!")
    }
    
    private func setupUI() {
        
        addSubview(self.contentStack)
        
        NSLayoutConstraint.activate([
            
            self.contentStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            self.contentStack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            self.gameWodrLabel.centerXAnchor.constraint(equalTo: self.gameImage.centerXAnchor),
            self.gameWodrLabel.centerYAnchor.constraint(equalTo: self.gameImage.centerYAnchor),
            
            self.wrongAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.wrongAnswerBtn.heightAnchor.constraint(equalToConstant: 108),
            self.rightAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.rightAnswerBtn.heightAnchor.constraint(equalToConstant: 108)
            
        ])
    }
}

private extension GameScreenView {
    
    func makeButton(color: UIColor, image: String) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = color
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.setImage(UIImage(named: image), for: .normal)
        return btn
    }
}