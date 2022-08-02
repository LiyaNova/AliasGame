//
//  AlertManager.swift
//  Alias
//
//  Created by Alex Ch. on 29.07.2022.
//

import UIKit

final class AlertForExitApp {
    
    private var myTargetView: UIView?
    var buttonHandler: (() -> Void)?
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    // MARK: - UI elements
    
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private lazy var alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    // Кнопка - остаться
    
    private  lazy var stayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Остаться", for: .normal)
        button.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        button.addTarget(self, action: #selector(holdDown), for: .touchDown)
        
        return button
    }()
    
    // Кнопка - выйти
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(dismissAlertAndCloseApp), for: .touchUpInside)
        button.addTarget(self, action: #selector(holdDown), for: .touchDown)
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Phosphate-Solid", size: 20)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Piazzolla", size: 17)
        return label
    }()
    
    
    //MARK: - Methods
    
    func showCustomAlert(with title: String,
                         message: String,
                         on viewController: UIViewController) {
        
        guard let targetView = viewController.view else { return }
        
        self.myTargetView = targetView
        
        self.backgroundView.frame = targetView.bounds
        targetView.addSubview(self.backgroundView)
        targetView.addSubview(self.alertView)
        
        self.alertView.frame = CGRect(x: 40,
                                      y: -300,
                                      width: targetView.frame.size.width - 80,
                                      height: 300)
        
        self.titleLabel.text = title
        self.messageLabel.text = message
        self.setupUI()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.alertView.center = targetView.center
                }
            }
        })
    }
    
    private func deleteAlpha(){
        self.alertView.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
    }
    
    private func createView(){
        
        guard let targetView = self.myTargetView else {return}
        self.alertView.frame = CGRect(x: 40,
                                      y: targetView.frame.size.height,
                                      width: targetView.frame.size.width - 80,
                                      height: 300)
    }
    
    // Закрыть алерт без выхода из приложения
    @objc func dismissAlert(_ sender: UIButton){
        
        reverseBackground(sender)
        
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.createView()
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: {
                    done in
                    if done {
                        self.deleteAlpha()
                    }
                })
            }
        })
    }
    
    //Закрыть алерт и закрыть приложение
    @objc private func dismissAlertAndCloseApp(_ sender: UIButton){
        
        reverseBackground(sender)
        
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.createView()
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: {
                    done in
                    if done {
                        self.deleteAlpha()
                        self.buttonHandler?()
                    }
                })
            }
        })
    }
    
    private func reverseBackground(_ sender: UIButton){
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    
    @objc  func holdDown(_ sender: UIButton){
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    
    // MARK: - Setup constraints
    private func setupUI() {
        
        alertView.addSubview(self.stayButton)
        alertView.addSubview(self.exitButton)
        alertView.addSubview(self.titleLabel)
        alertView.addSubview(self.messageLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.alertView.topAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 24),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -24),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 11),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 24),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -24),
            
            self.stayButton.bottomAnchor.constraint(equalTo: self.exitButton.topAnchor, constant: -11),
            self.stayButton.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 24),
            self.stayButton.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -24),
            self.stayButton.heightAnchor.constraint(equalToConstant: 55),
            
            self.exitButton.bottomAnchor.constraint(equalTo: self.alertView.bottomAnchor, constant: -11),
            self.exitButton.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 24),
            self.exitButton.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -24),
            self.exitButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
