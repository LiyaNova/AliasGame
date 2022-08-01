
import Foundation

class GameRound {
//
//    public var nextWordHandler: ((String) -> Void)?
//    public var remainingRoundSecHandler: ((TimeInterval) -> Void)?
//
//    //Продолжительность раунда
//    let roundDuration: TimeInterval
//
//    /// Номер раунда
//    let number: Int
//
//    /// Команда, которая щас играет свой раунд
//    let team: GameTeam
//
//    let words: [String]
//
//    private var currentWordIndex = 0
//    private var timer: Timer? = nil
//    private var elapsedSec: TimeInterval = 0
//
//    private var roundEndHandler: ((_ accuredScores: Int) -> (Void))?
//
//    private var accuredScores = 0
//
//    // MARK: Init
//
//    public init(
//        roundDuration: TimeInterval,
//        number: Int,
//        team: GameTeam,
//        words: [String]
//    ) {
//        self.roundDuration = roundDuration
//        self.number = number
//        self.team = team
//        self.words = words
//    }
//
//    // MARK: API
//
//    public func start(completion: @escaping (_ accuredScores: Int) -> (Void)) {
//        self.roundEndHandler = completion
//
//        self.startGameTimer()
//        self.sendNextWord(needIncrementIndex: false)
//    }
//
//    public func cancelCurrentWord() {
//        self.sendNextWord()
//    }
//
//    public func wordGuessed() {
//        self.accuredScores += 1
//        self.sendNextWord()
//    }

}

//// MARK: - Private impl
//private extension RoundRound {
//
//    func sendNextWord(needIncrementIndex: Bool = true) {
//        if needIncrementIndex {
//            self.currentWordIndex += 1
//        }
//
//        let currWord = self.words[self.currentWordIndex]
//        self.nextWordHandler?(currWord)
//    }
//
//}
//
//// MARK: Timer staff
//private extension RoundRound {
//
//    func startGameTimer() {
//        self.timer = Timer.scheduledTimer(
//            timeInterval: 1,
//            target: self,
//            selector: #selector(self.timerTick),
//            userInfo: nil,
//            repeats: true
//        )
//    }
//
//    @objc func timerTick() {
//        self.elapsedSec += 1
//
//        let remainingSec = self.roundDuration - self.elapsedSec
//        self.remainingRoundSecHandler?(remainingSec)
//
//        if remainingSec <= 0 {
//            self.invalidateTimer()
//
//            self.roundEndHandler?(self.accuredScores)
//        }
//    }
//
//    func invalidateTimer() {
//        self.timer?.invalidate()
//        self.timer = nil
//    }
//
//}
