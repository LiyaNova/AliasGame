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
        label.font = UIFont(name: "PhosphateRR Solid", size: 72)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var secondsTextLabel: UILabel = {
        let label = UILabel()
        label.text = "секунд seconds"
        label.textColor = .black
//        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.font = UIFont(name: "Phosphate_Pro_Inline", size: 24)

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
        
        view.addSubview(secondsLabel)
        view.addSubview(secondsTextLabel)
        
        NSLayoutConstraint.activate([
            
            secondsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secondsLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            secondsLabel.widthAnchor.constraint(equalToConstant: 100),
            
            secondsTextLabel.topAnchor.constraint(equalTo: secondsLabel.bottomAnchor, constant: 5),
            secondsTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondsTextLabel.widthAnchor.constraint(equalToConstant: 1000)
        ])
    }

}
