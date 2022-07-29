//
//  TeamModel.swift
//  Alias
//
//  Created by Tatyana Sidoryuk on 29.07.2022.
//

import Foundation

struct Team {
    
    var name: String
    
    var scores: Int = 0 // счет
    
    mutating func setTeamName (newName: String) {
        name = newName
    }
    
    mutating func rightAnswer (number: Int) {
        scores += 1
    }
    
    mutating func wrongAnswer () {
        scores -= 1
    }
}
