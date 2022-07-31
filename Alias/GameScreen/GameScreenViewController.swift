
import UIKit
import AVFoundation

class GameScreenViewController: UIViewController {
    
    // Переменная и ее инициализатор для передачи данных о словах в соотвествии с выбранным уровнем
    var words: [String] = ["авиация"]
    
    init(words: [String]) {
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
        gameScreenView.gameWodrLabel.text = words[0]
        
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
            self.musicManager.playSound(soundName: "Right Answer")
        }
    }
    
    func wrongButtonTapped(){
        gameScreenView.wrongButtonTap = {
            [weak self] in
            guard let self = self else { return }
            self.musicManager.playSound(soundName: "Wrong Answer")
        }
    }
}


//  self.alertManager.showCustomAlert(with: "ВЫЙТИ В ГЛАВНОЕ МЕНЮ?", message: "При выходе в главное меню текущая игра будет сброшена, а баллы не сохранятся.", on: self)
//
//    @objc func dismissAlert(){
//        self.alertManager.dismissAlert()
//    }
