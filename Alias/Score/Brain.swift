//
//  Brain.swift
//  Alias
//
//  Created by Alex Ch. on 29.07.2022.
//

import UIKit

struct Brain {
    
    var scoreDict = ["Команда 2": 10, "Команда 3": 8, "Команда 1": 7]
    var numberOfRound = 2
    var gameButtonTap: (() -> Void)?
    
    var maximumScore: Int {
        return scoreDict.values.max() ?? 0
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
    
    func team(name: [String: Int])-> [String] {
        let team = [String](name.keys)
        return team
    }
    
    func score(name: [String: Int])-> [Int] {
        let score = [Int](scoreDict.values).sorted(by: >)
        return score
    }
}
