
import Foundation

class Teams {
    var randomTeamNames = ["K1", "K2" , "K3", "K4", "K5"]
    
    func makeTeams(count: Int) -> [Team] {
        guard count < self.randomTeamNames.count else { return [] }
        
        let shuffledNames = self.randomTeamNames.shuffled()
        return shuffledNames[..<count].map { Team(name: $0) }
    }
    
    func makeNewTeam() -> Team {
        var team = Team(name: "")
        team.name = randomTeamNames.randomElement() ?? "Команда мечты"
        
        return team
    }
}

