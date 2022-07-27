//
//  ViewController.swift
//  Alias
//
//  Created by Olga on 26.07.2022.
//

import UIKit

class StartMenuViewController: UIViewController {
    
    private let startMenuView = StartMenuView()

    override func loadView() {
        self.view = self.startMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMenuView.rulesMenuButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let vc = RulesViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}

