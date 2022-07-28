//
//  TeamsMenuViewController.swift
//  Alias
//
//  Created by Tatyana Sidoryuk on 27.07.2022.
//

import Foundation

import UIKit

class TeamsMenuViewController: UIViewController {
    
    private let teamsMenuView = TeamsMenuView()
    
    override func loadView() {
        self.view = self.teamsMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
