
import Foundation

protocol ICanGenerateNewGameWord: AnyObject {
    
    /// Функция для формирования нового слова
    func getNewWordToGuess() -> String
}

protocol IGameEngineDelegate: AnyObject {
    /// Команда завершила свой раунд
    func gameTeamRoundEnd(game: GameEngine, round: Int, teams: [Team], nextPlayingTeam: Team)
    /// Раунд завершился для всех команд
    func gameRoundEnd(game: GameEngine, round: Int, teams: [Team], nextPlayingTeam: Team)
    ///Завершилась вся игра, одна из команд победила
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
    
    /// Текущий раунд игры
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

    /// Запускаем новый раунд
    func startNewRound() -> GameRound {
        let playingTeam = self.nextPlayingTeam

        let round = GameRound(
            newWordGenerator: self,
            roundDuration: self.roundDuration,
            team: playingTeam
        )

        round.start() {
            // Вызов в конце раунда, передача набранных очков текущей команды
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

extension GameEngine: ICanGenerateNewGameWord {
    
    func getNewWordToGuess() -> String {
        guard !self.gameWords.isEmpty else { return "[Слова для игры закончились]" }
        
        let wordIndex = Int.random(in: 0..<self.gameWords.count)
        let word = self.gameWords[wordIndex]
        self.gameWords.remove(at: wordIndex)
        
        return word
    }
    
}

private extension GameEngine {
    
    /// Получаем общие очки команды за несколько раундов
    func handleTeamRoundEnd(playingTeam: Team, with accuredScores: Int) {
        playingTeam.scores += accuredScores

        // Все команды сыграли текущий раунд, если индекс игравшей команды = числу команд
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
        
        // фильтруем все команды и получаем команды с набранными очками, которых достаточно для победы
        let teamsWithScoresEnougthToWin = self.teams.filter { $0.scores >= self.scoresToWin }.sorted()
        
        // Проверка на команды с одинаковым количеством очков
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
    
    /// сообщаем о завершении текущего раунда и передаем текущие данные
    func endCurrentRound() {
        self.delegate?.gameRoundEnd(
            game: self,
            round: self.currentRoundIndex,
            teams: self.teams,
            nextPlayingTeam: self.nextPlayingTeam
        )
    }

}
