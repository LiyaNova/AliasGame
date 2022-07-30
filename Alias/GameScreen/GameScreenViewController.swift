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
    private let musicManager = MusicModel()
    
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.gameScreenView
        rightButtonTapped()
        wrongButtonTapped()
        
    }
    
    func rightButtonTapped(){
        gameScreenView.rightButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let alert = self.alertManager.showAlert(text: "Верно!")
            self.present(alert, animated: true, completion: nil)
            self.musicManager.playSound(soundName: "Right Answer")
        }
    }
    
    func wrongButtonTapped(){
        gameScreenView.wrongButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let alert = self.alertManager.showAlert(text: "Неверно!")
            self.present(alert, animated: true, completion: nil)
            self.musicManager.playSound(soundName: "Wrong Answer")
        }
    }
    
}
