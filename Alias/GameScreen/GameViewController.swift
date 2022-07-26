//
//  GameViewController.swift
//  Alias
//
//  Created by Alex Ch. on 26.07.2022.
//

import UIKit

class GameViewController: UIViewController {
    
// MARK: - UI elements
    
    private lazy var secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "27"
        label.textColor = .black
        label.font = .systemFont(ofSize: 72, weight: .bold)
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        view.addSubview(self.secondsLabel)
        
        NSLayoutConstraint.activate([
            
            secondsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secondsLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            secondsLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

}
