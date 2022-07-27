//
//  GameViewController.swift
//  Alias
//
//  Created by Alex Ch. on 26.07.2022.
//

import Foundation
import SwiftUI

struct SwiftUIController: UIViewControllerRepresentable {
    typealias UIViewControllerType = GameViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = UIViewControllerType()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct SwiftUIController_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIController().edgesIgnoringSafeArea(.all)
    }
}

import UIKit

class GameViewController: UIViewController {
    
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
    private lazy var trueAnswerBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setImage(UIImage(named: "Ok"), for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(trueAnswerTap), for: .touchUpInside)
        return button
    }()
    
    // Кнопка неправильного ответа
    private lazy var wrongAnswerBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setImage(UIImage(named: "WrongAnswer"), for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(wrongAnswerTap), for: .touchUpInside)
        return button
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
        let stack = UIStackView(arrangedSubviews: [self.wrongAnswerBtn, self.trueAnswerBtn])
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
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    
    @objc func wrongAnswerTap(){
        print("Wrong answer")
    }
    
    @objc func trueAnswerTap(){
        print("Right answer")
    }
    
    private func setupUI() {
        
        view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            
            self.contentStack.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.contentStack.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            
            self.gameWodrLabel.centerXAnchor.constraint(equalTo: gameImage.centerXAnchor),
            self.gameWodrLabel.centerYAnchor.constraint(equalTo: gameImage.centerYAnchor),
            
            self.wrongAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.wrongAnswerBtn.heightAnchor.constraint(equalToConstant: 108),
            self.trueAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.trueAnswerBtn.heightAnchor.constraint(equalToConstant: 108)
            
        ])
    }
}
