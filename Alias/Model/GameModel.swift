//
//  GameModel.swift
//  Alias
//
//  Created by Tatyana Sidoryuk on 29.07.2022.
//

import Foundation

struct Game {
    
    var teams: [Team]
    
    var numberOfTeams: Int {
        teams.count
    }
    mutating func addTeams () { // когда нажимают на плюс
        let new = Team(name: "Команда", scores: 0)
        teams.append(new)
    }

    mutating func deleteLastTeam () { // когда нажимают на минус
        teams.removeLast()
    }
}

