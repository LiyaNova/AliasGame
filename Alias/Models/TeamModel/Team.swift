
import Foundation

class Team {
    var name: String
    var scores: Int = 0
    
    init(name: String, scores: Int) {
        self.name = name
        self.scores = scores
    }
}
