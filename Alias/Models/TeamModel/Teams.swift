//
//  GameModel.swift
//  Alias
//
//  Created by Tatyana Sidoryuk on 29.07.2022.
//

import Foundation

class Teams {
    var randomTeamNames = ["Хомяки", "Пираты" , "Смайлики", "Булавки", "Кнопочки", "Улет", "Динамит", "Звезды", "Котики", "Космонавты", "Ехидны", "Сухари", "Оладушки", "Звери", "Ребята"]
    
    func makeTeams(count: Int) -> [Team] {

        guard count < self.randomTeamNames.count else { return [] }
        let shuffledNames = self.randomTeamNames.shuffled()
        for i in 0..<count {
            randomTeamNames = randomTeamNames.filter({ $0 != shuffledNames[i] })
        }
        
        return shuffledNames[..<count].map { Team(name: $0) }
    }
    
    func makeNewTeam() -> Team {
        var team = Team(name: "")
        let thisElement = randomTeamNames.randomElement() ?? "Команда мечты"
        team.name = thisElement
        randomTeamNames = randomTeamNames.filter({ $0 != thisElement })
        
        return team
    }
}

