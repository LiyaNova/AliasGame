
import Foundation

public enum GameDifficulty {
    case easy
    case normal
    case hard
}

protocol IGameEngineDelegate: AnyObject {
    func gameTeamRoundEnd(game: GameEngine, round: Int, teams: [Team], nextPlayingTeam: Team)
    func gameRoundEnd(game: GameEngine, round: Int, teams: [Team], nextPlayingTeam: Team)
    func gameEnded(game: GameEngine, round: Int, teams: [Team], teamWin: Team)
    
}

class GameEngine {
    var delegate: IGameEngineDelegate?
    /// Число очков, которые нужно набрать команде, чтобы выиграть игру
    let scoresToWin: Int
    /// Продолжительность одного раунда (сек)
    let roundDuration: TimeInterval
    let teams: [Team]
    var gameWords: [String]
    var playingTeamIndx: Int = 0
    var currentRoundIndex: Int
    private(set) var currentRound: GameRound?
    
    private var nextPlayingTeam: Team {
        self.teams[self.playingTeamIndx]
    }

    // MARK: Init

    init(
        scoresToWin: Int,
        roundDuration: TimeInterval,
        teams: [Team],
        currentRoundIndex: Int,
        gameWords: [String]
    ) {
        self.scoresToWin = scoresToWin
        self.roundDuration = roundDuration
        self.teams = teams
        self.currentRoundIndex = currentRoundIndex
        self.gameWords = gameWords.shuffled()
    }
}

// MARK: - Game flow
extension GameEngine {

    func startNewRound() -> GameRound {
        let playingTeam = self.nextPlayingTeam

        let round = GameRound(
            gameEngine: self,
            roundDuration: self.roundDuration,
            number: self.currentRoundIndex,
            team: playingTeam
        )

        round.start() {
            [weak self] accuredScores in
            guard let self = self else { return }

            self.handleTeamRoundEnd(
                playingTeam: playingTeam,
                with: accuredScores
            )
        }
        self.currentRound = round
        
        return round
    }
    
    func getNewWordToGuess() -> String {
        guard !self.gameWords.isEmpty else { return "[Слова для игры закончились]" }
        
        let wordIndex = Int.random(in: 0..<self.gameWords.count)
        
        let word = self.gameWords[wordIndex]
        self.gameWords.remove(at: wordIndex)
        
        return word
    }

}

private extension GameEngine {
    
    func handleTeamRoundEnd(playingTeam: Team, with accuredScores: Int) {
        playingTeam.scores += accuredScores

        let isAllTeamsPlayedCurrentRound = self.playingTeamIndx == self.teams.count - 1

        if isAllTeamsPlayedCurrentRound {
            self.endRoundOrGame()
        } else {
            self.playingTeamIndx += 1

            self.delegate?.gameTeamRoundEnd(
                game: self,
                round: self.currentRoundIndex,
                teams: self.teams,
                nextPlayingTeam: self.nextPlayingTeam
            )
        }
    }
    
    func endRoundOrGame() {
        self.playingTeamIndx = 0
        self.currentRoundIndex += 1
        
        let teamsWithScoresEnougthToWin = self.teams.filter { $0.scores >= self.scoresToWin }.sorted()
        
        let isExistTeamsWithEqualsScores: Bool = {
            let teamsScores = teamsWithScoresEnougthToWin.map { $0.scores }
            let teamScoresSet: Set<Int> = Set(teamsScores)
            
            return teamScoresSet.count < teamsScores.count
        }()
        
        // Еще никто не набрал нужного числа очков чтобы победить - завершаем текущий раунд
        if teamsWithScoresEnougthToWin.isEmpty {
            self.endCurrentRound()
        }
        // или есть команды с одинаковым числом очков - завершаем текущий раунд
        else if isExistTeamsWithEqualsScores {
            self.endCurrentRound()
        }
        // Иначе - у нас таки есть победитель
        else {
            let winTeam = teamsWithScoresEnougthToWin.first!
            
            self.delegate?.gameEnded(
                game: self,
                round: self.currentRoundIndex,
                teams: self.teams,
                teamWin: winTeam
            )
        }
        
    }
    
    func endCurrentRound() {
        self.delegate?.gameRoundEnd(
            game: self,
            round: self.currentRoundIndex,
            teams: self.teams,
            nextPlayingTeam: self.nextPlayingTeam
        )
    }

}
