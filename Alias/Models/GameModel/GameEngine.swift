
import Foundation

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
    let gameWords: [String]
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
        self.gameWords = gameWords
    }
}

// MARK: - Game flow
extension GameEngine {

    func startNewRound() -> GameRound {
        let playingTeam = self.nextPlayingTeam

        let round = GameRound(
            roundDuration: self.roundDuration,
            number: self.currentRoundIndex,
            team: playingTeam,
            words: gameWords
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
        
        // По результатам раунда есть победившая команда
        if let winTeam = self.teams.first(where: { $0.scores >= self.scoresToWin }) {
            self.delegate?.gameEnded(
                game: self,
                round: self.currentRoundIndex,
                teams: self.teams,
                teamWin: winTeam
            )
        }
        // Еще никто не выиграл - завершаем текущий раунд
        else {
            self.delegate?.gameRoundEnd(
                game: self,
                round: self.currentRoundIndex,
                teams: self.teams,
                nextPlayingTeam: self.nextPlayingTeam
            )
        }
    }
}
