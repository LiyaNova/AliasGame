//
//  NetworkManager.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import Foundation

// MARK: - Protocol

protocol NetworkManagerDelegate: AnyObject {
    func showData(results: JokeModel)
}

final class NetworkManager {
    
    private let api = Api()
    weak var delegate: NetworkManagerDelegate?
    
    // MARK: - Methods
    
    func fetchData(url: String) {
        api.decodeData(url: url) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let joke):
                DispatchQueue.main.async {
                    if let joke = joke {
                        self.delegate?.showData(results: joke)
                    }
                }
            case .failure(_):
                print("Нет шутки")
            }
        }
    }
}
