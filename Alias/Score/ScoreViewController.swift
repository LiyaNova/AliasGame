
import UIKit

// MARK: - IGameEngineDelegate
extension ScoreViewController: IGameEngineDelegate {

    func gameTeamRoundEnd(game: GameEngine, round: Int, teams: [Team], nextPlayingTeam: Team) {
        print("gameTeamRoundEnd teams: \(teams)")
        
        self.closeGameScreenAndUpdateShowTeamsScores(teams)
        self.scoreView.readyToGameTeamLabel.text = nextPlayingTeam.name
    }

    func gameRoundEnd(game: GameEngine, round: Int, teams: [Team], nextPlayingTeam: Team) {
        print("gameRoundEnd teams: \(teams), round: \(round)")
        
        self.closeGameScreenAndUpdateShowTeamsScores(teams)
        self.scoreView.numberOfRound = round
        
        self.scoreView.readyToGameTeamLabel.text = nextPlayingTeam.name
    }
    
    func gameEnded(game: GameEngine, round: Int, teams: [Team], teamWin: Team) {
        let myFinalists = Array(teams.sorted().prefix(3))
        self.gameScreenVC?.dismiss(animated: false)
        let resultVC = ResultScreenViewController(
            finalists: myFinalists
        )
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
}

// MARK: - Game flow
private extension ScoreViewController {
    
    func closeGameScreenAndUpdateShowTeamsScores(_ teams: [Team]) {
        self.gameScreenVC?.dismiss(animated: true)
        self.scoreView.teams = teams.sorted()
    }
}

class ScoreViewController: CustomViewController {
    
    override var nameViewControler: String { "РЕЙТИНГ \nКОМАНД" }
    
    private let alertManager = AlertForExitApp()
    private var startNewRount: Bool = false
    private var teams: [Team]
    private var gameWords: [String]
    
    private lazy var game = GameEngine(
        scoresToWin: 5,
        roundDuration: 3,
        teams: self.teams,
        currentRoundIndex: 0,
        gameWords: self.gameWords
    )
    
    private lazy var scoreView = ScoreView(
        teams: self.teams,
        playingTeamIndx: self.game.playingTeamIndx,
        numberOfRound: self.game.currentRoundIndex
    )
    
    private var gameScreenVC: GameScreenViewController?
    
    init(teams: [Team], gameWords: [String]) {
        self.teams = teams
        self.gameWords = gameWords
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scoreView)
        NSLayoutConstraint.activate([
            self.scoreView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scoreView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scoreView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scoreView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor)
        ])
        
        self.game.delegate = self
        
        self.scoreView.gameButtonTap = {
            [weak self] in
            guard let self = self else { return }
            
            let round = self.game.startNewRound()
            self.showGameScreen(round)
            self.startNewRount = true
        }
    }
    
    override func popViewControler() {
        
        if self.startNewRount {
            self.alertManager.showCustomAlert(with: "ВЫЙТИ В ГЛАВНОЕ МЕНЮ?", message: "При выходе в главное меню текущая игра будет сброшена, а баллы не сохранятся", on: self)
            self.alertManager.buttonHandler = {
                [weak self] in
                guard let self = self else { return }
                self.navigationController?.popToRootViewController(animated: true)
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension ScoreViewController {
    
    func showGameScreen(_ round: GameRound) {
        let vc =  GameScreenViewController(round: round)
        self.gameScreenVC = vc
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
//  self.alertManager.showCustomAlert(with: "ВЫЙТИ В ГЛАВНОЕ МЕНЮ?", message: "При выходе в главное меню текущая игра будет сброшена, а баллы не сохранятся.", on: self)
//
//    @objc func dismissAlert(){
//        self.alertManager.dismissAlert()
//    }
