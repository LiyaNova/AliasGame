
import Foundation

protocol IGameEngineDelegate: AnyObject {
    func gameNextWord(game: GameEngine, word: String)
    func gameTeamRoundRemainingTimeChanged(game: GameEngine, remainingTime: TimeInterval)
    func gameTeamRoundEnd(game: GameEngine, round: Int, teamScoresInfo: Team)
    func gameRoundEnd(game: GameEngine, round: Int, teamsScoresInfo: [Team])
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

    // MARK: Init

    init(
        scoresToWin: Int = 20,
        roundDuration: TimeInterval = 60,
        teams: [Team] = TeamsMenuViewController(minNumberOfTeams: 2, maxNumberOfTeams: 10).teams,
        currentRoundIndex: Int = 0,
        gameWords: [String] = DifficultyChoiceModel().getWords()
    ) {
        self.scoresToWin = scoresToWin
        self.roundDuration = roundDuration
        self.teams = teams
        self.currentRoundIndex = currentRoundIndex
        self.gameWords = gameWords
    }
}

// MARK: - Game flow
//extension GameEngine {
//
//    func startNewRound() {
//        let playingTeam = self.teams[self.playingTeamIndx]
//
//        self.currentRound = GameRound(
//            roundDuration: self.roundDuration,
//            number: self.currentRoundIndex,
//            team: playingTeam,
//            words: ["хуй", "пизда", "сковорода"] // TODO: взять из gameWords новые слова
//        )
//
//        self.currentRound?.nextWordHandler = {
//            [weak self] word in
//            guard let self = self else { return }
//
//            self.delegate?.gameNextWord(game: self, word: word)
//        }
//
//        self.currentRound?.remainingRoundSecHandler = {
//            [weak self] remainingSec in
//            guard let self = self else { return }
//
//            self.delegate?.gameTeamRoundRemainingTimeChanged(game: self, remainingTime: remainingSec)
//        }
//
//        self.currentRound?.start() {
//            [weak self] accuredScores in
//            guard let self = self else { return }
//
//            self.handleTeamRoundEnd(
//                playingTeam: playingTeam,
//                with: accuredScores
//            )
//        }
//    }
//
//    func handleTeamRoundEnd(playingTeam: Team, with accuredScores: Int) {
//        playingTeam.scores += accuredScores
//
//        let isAllTeamsPlayedCurrentRound = self.playingTeamIndx == self.teams.count - 1
//
//        if isAllTeamsPlayedCurrentRound {
//            self.delegate?.gameRoundEnd(
//                game: self,
//                round: self.currentRoundIndex,
//                teamsScoresInfo: self.teams
//            )
//        } else {
//            self.playingTeamIndx += 1
//            
//            self.delegate?.gameTeamRoundEnd(
//                game: self,
//                round: self.currentRoundIndex,
//                teamScoresInfo: playingTeam
//            )
//        }
//    }
//}
