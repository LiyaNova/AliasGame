//
//  ScoreViewController.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import UIKit


class ScoreViewController: UIViewController {
    
    private let scoreView = ScoreView()
    private let networkManager = NetworkManager()
    private let api = Api()
    private var jokes: JokeModel?
    
    override func loadView() {
        self.view = self.scoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        networkManager.fetchData(url: api.baseURL)
        
        scoreView.gameButtonTap = {
            [weak self] in
            guard let self = self else { return }
            //Прописала nil в созданный инициализатор, чтобы не ругался
            let vc = GameScreenViewController(words: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
}


extension ScoreViewController: NetworkManagerDelegate {
    func showData(results: JokeModel) {
        jokes = results
    }
}
