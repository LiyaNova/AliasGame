
import UIKit
import AVFoundation

protocol IGameScreenDelegate: AnyObject {
    func didCancelGame()
}

class GameScreenViewController: UIViewController {
    
    weak var delegate: IGameScreenDelegate?
    
    private let alertManager = AlertForExitApp()
    private let round: GameRound
    private lazy var gameScreenView = GameScreenView(round: self.round)
    private lazy var musicManager = MusicModel()
    
    init(round: GameRound) {
        self.round = round
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.gameScreenView
        self.setupButtonHandlers()
        
        self.round.nextWordHandler = {
            [weak self] word in
            guard let self = self else { return }
            
            self.gameScreenView.gameWordLabel.text = word
        }

        self.round.remainingRoundSecHandler = {
            [weak self] remainingSec in
            guard let self = self else { return }

            self.gameScreenView.secondsLabel.text = "\(remainingSec)"
        }
    }
}

private extension GameScreenViewController {
    
    func setupButtonHandlers() {
        self.gameScreenView.rightButtonTap = {
            [weak self] in
            guard let self = self else { return }
            
            self.musicManager.playSound(soundName: "Right Answer")
            self.round.wordGuessed()
        }
        
        self.gameScreenView.wrongButtonTap = {
            [weak self] in
            guard let self = self else { return }
            
            self.musicManager.playSound(soundName: "Wrong Answer")
            self.round.cancelCurrentWord()
        }
        
        self.gameScreenView.backButtonTap = {
            [weak self] in
            guard let self = self else { return }
            
            self.alertManager.showCustomAlert(with: "ВЫЙТИ В ГЛАВНОЕ МЕНЮ?", message: "При выходе в главное меню текущая игра будет сброшена, а баллы не сохранятся", on: self)
            self.alertManager.buttonHandler = {
                [weak self] in
                guard let self = self else { return }
                
                self.dismiss(animated: false)
                self.delegate?.didCancelGame()
            }
        }
    }
    
}
