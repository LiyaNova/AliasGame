//
//  ScoreViewController.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import UIKit


class ScoreViewController: UIViewController {
    
    private let scoreView = ScoreView()
    
    override func loadView() {
        self.view = self.scoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
