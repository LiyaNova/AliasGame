//
//  ResultScreenViewController.swift
//  Alias
//
//  Created by Юлия Филимонова on 29.07.2022.
//

import UIKit

class ResultScreenViewController: UIViewController {

    let resultScreenView = ResultScreenView()

    override func loadView() {
        self.view = self.resultScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
       
}
