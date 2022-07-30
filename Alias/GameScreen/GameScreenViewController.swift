//
//  GameScreenViewController.swift
//  Alias
//
//  Created by Alex Ch. on 26.07.2022.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    private let gameScreenView = GameScreenView()
    private let alertManager = AlertManager()
    
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.gameScreenView
        rightButtonTapped()
        wrongButtonTapped()
        
        
        gameScreenView.openScore = {
            [weak self] in
            guard let self = self else { return }
            let vc = ScoreViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    func rightButtonTapped(){
        gameScreenView.rightButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let alert = self.alertManager.showAlert(text: "Верно!")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func wrongButtonTapped(){
        gameScreenView.wrongButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let alert = self.alertManager.showAlert(text: "Неверно!")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
