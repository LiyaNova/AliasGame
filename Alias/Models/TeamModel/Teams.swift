
import Foundation

class Teams {
     private var randomTeamNames = [
        "Хомяки", "Пираты" , "Смайлики", "Булавки", "Кнопочки", "Улет", "Динамит", "Звезды", "Котики", "Космонавты", "Ехидны", "Сухари", "Оладушки", "Звери", "Ребята", "Выдры", "Орлы", "Сырники", "Пельмешки", "Крутые"
    ]
    
    func makeTeams(count: Int) -> [Team] {
        guard count < self.randomTeamNames.count else { return [] }
        let shuffledNames = self.randomTeamNames.shuffled()
        
        let teamNames = shuffledNames[..<count]
        
//        self.usedNames.append(contentsOf: teamNames)
        self.randomTeamNames.removeAll { teamNames.contains($0) }
        
        return teamNames.map { Team(name: $0, scores: 0) }
    }
    
    func makeNewTeam() -> Team {
        guard !self.randomTeamNames.isEmpty else { return Team(name: "Команда мечты") }
        
        let teamName = self.randomTeamNames.randomElement()!
        self.randomTeamNames.removeAll { $0 == teamName }
        
       return Team(name: teamName, scores: 0)
    }
    
    func makeNewTeamName(name: String) -> Team {
        let team = Team(name: name, scores: 0)
        return team
    }

}

