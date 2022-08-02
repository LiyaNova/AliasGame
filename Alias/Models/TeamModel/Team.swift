
import Foundation

class Team: Comparable {
    var name: String
    var scores: Int = 0
    
    init(name: String, scores: Int = 0) {
        self.name = name
        self.scores = scores
    }
    
    static func < (lhs: Team, rhs: Team) -> Bool {
        lhs.scores > rhs.scores
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.name == rhs.name
    }
}

extension Team: CustomStringConvertible {

    public var description: String {
        "Name: '\(self.name)', Scores: \(self.scores)"
    }

}
