
import Foundation

class Teams {
    var randomTeamNames = ["Хомяки", "Пираты" , "Смайлики", "Булавки", "Кнопочки", "Улет", "Динамит", "Звезды", "Котики", "Космонавты", "Ехидны", "Сухари", "Оладушки", "Звери", "Ребята", "Выдры", "Орлы", "Сырники", "Пельмешки", "Крутые"]
    
    func makeTeams(count: Int) -> [Team] {

        guard count < self.randomTeamNames.count else { return [] }
        let shuffledNames = self.randomTeamNames.shuffled()
        
        return shuffledNames[..<count].map { Team(name: $0, scores: 0) }
    }
    
    func makeNewTeam() -> Team {
        var team = Team(name: "")
        team.name = randomTeamNames.randomElement() ?? "Команда мечты"
        
        return team
    }
}

