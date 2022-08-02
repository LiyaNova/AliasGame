//
//  JokeView.swift
//  Alias
//
//  Created by Alex Ch. on 31.07.2022.
//

import UIKit

class JokeView: UIView {
    
    var newGameButtonTap: (()->())?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var setupLabel: UILabel = { // лейбл шутки
        let label = UILabel()
        label.text = "Шутка"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Piazzolla", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    lazy var jokeLabel: UILabel = { // лейбл шутки
        let label = UILabel()
        label.text = "Сейчас будет шутка!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "Piazzolla", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var continueButton: UIButton = { // кнопка продолжить
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("НОВАЯ ИГРА!", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        btn.titleLabel?.textColor = .black
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 16
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func newGame(){
        self.newGameButtonTap?()
        JokeViewController().dismiss(animated: false)
    }
    
    
    func setupView(model: JokeModel) {
        jokeLabel.text = model.punchline
    }
    
    private func setupUI(){
        addSubview(self.mainView)
        mainView.addSubview(continueButton)
        mainView.addSubview(jokeLabel)
        
        NSLayoutConstraint.activate([
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.jokeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.jokeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.jokeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.jokeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.continueButton.heightAnchor.constraint(equalToConstant: 66),
            self.continueButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.continueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.continueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
}
