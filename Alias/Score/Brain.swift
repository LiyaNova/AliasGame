//
//  Brain.swift
//  Alias
//
//  Created by Alex Ch. on 29.07.2022.
//

import Foundation

struct Brain {
    
    var scoreDict = ["Команда 2": 10, "Команда 3": 8, "Команда 1": 7]
    var numberOfRound = 2
    var gameButtonTap: (() -> Void)?
    
    var maximumScore: Int {
        return scoreDict.values.max() ?? 0
    }
    
    
}
