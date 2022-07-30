//
//  TeamsMenuViewController.swift
//  Alias
//
//  Created by Tatyana Sidoryuk on 27.07.2022.
//

import Foundation

import UIKit

class TeamsMenuViewController: UIViewController {
    
    let minNumberOfTeams: Int
    let maxNumberOfTeams: Int
    
    private lazy var teamsMenuView = TeamsMenuView(minNumberOfTeams: self.minNumberOfTeams, maxNumberOfTeams: self.maxNumberOfTeams, frame: .zero)
    
    override func loadView() {
        self.view = self.teamsMenuView
    }
    
    init(minNumberOfTeams: Int, maxNumberOfTeams: Int) {
        self.minNumberOfTeams = minNumberOfTeams
        self.maxNumberOfTeams = maxNumberOfTeams
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstTwoTeams = Teams().makeTeams(count: minNumberOfTeams)
        self.teamsMenuView.teams = firstTwoTeams
        
        teamsMenuView.addNewTeam = {
            [weak self] in
            guard let self = self else { return }
            
            if self.teamsMenuView.teams.count != self.maxNumberOfTeams {
                self.teamsMenuView.teams.append(Teams().makeNewTeam())
            }
        }
        
        teamsMenuView.deleteTeam = {
            [weak self] in
            guard let self = self else { return }
            
            if self.teamsMenuView.teams.count != self.minNumberOfTeams {
                self.teamsMenuView.teams.removeLast()
            }
        }
    }
}
