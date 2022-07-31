
import UIKit

struct ScoreBrain {
    
    var teamName = ["Команда 2", "Команда 3", "Команда 1"]
    var teamScore = [1, 0, 4]
    
    var numberOfRound = 2
    var gameButtonTap: (() -> Void)?

    
    var maximumScore: Int {
        return teamScore.max() ?? -1
        
    }
    
    func sectionColor(section: Int)-> UIColor {
        var color: UIColor = .gray
        if section == 0 {
            color = UIColor(named: "RoyalBlueColor") ?? .gray
        } else if section == 1 {
            color = UIColor(named: "DarkPurpleColor") ?? .gray
        } else if section == 2 {
            color =  UIColor(named: "OrangeColor") ?? .gray
        }
        return color
    }
    
    func team()-> [String] {
        return teamName
    }
    
    func score()-> [Int] {
        return teamScore.sorted(by: >)
    }
    
    func showStar(labelScore: String)-> Bool {
        var parametr = true
        if labelScore == String(0) {
            return parametr
        } else if String(maximumScore) == labelScore {
            parametr = false
        }
        return parametr
    }
}
