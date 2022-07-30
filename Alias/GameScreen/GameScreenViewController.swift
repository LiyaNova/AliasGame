//
//  GameScreenViewController.swift
//  Alias
//
//  Created by Alex Ch. on 26.07.2022.
//

import UIKit

class GameScreenViewController: UIViewController {

  // Переменная и ее инициализатор для передачи данных о словах в соотвествии с выбранным уровнем
    var words: [String]?

     init(words: [String]?) {
        self.words = words
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let gameScreenView = GameScreenView()
    private let alertManager = AlertManager()
    private let musicManager = MusicModel()
    
   
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Для примера вывела на экран слово по выбранному уровню, у лейбла во GameScreenView текстполе закомментила
        gameScreenView.gameWodrLabel.text = words![0]
        
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
