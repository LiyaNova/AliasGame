//
//  GameScreenViewController.swift
//  Alias
//
//  Created by Alex Ch. on 26.07.2022.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    private let gameScreenView = GameScreenView()
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.gameScreenView
    }
    
    // MARK: - Private methods
    
    
    @objc func wrongAnswerTap(){
        print("Wrong answer")
    }
    
    @objc func trueAnswerTap(){
        print("Right answer")
    }
    

}
