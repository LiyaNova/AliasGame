//
//  ScoreView.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import UIKit

class ScoreView: UIView {

    var names = ["Команда 1", "Команда 2"]
    
    var numberOfTeams = 2
    
    private lazy var teamsLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинг команд"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        return label
    }()
    
    lazy var scoreTableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
         tableView.dataSource = self
         tableView.backgroundColor = .white
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.register(ScoreCell.self, forCellReuseIdentifier: "ScoreCell")
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
         tableView.delegate = self
         tableView.separatorStyle = .none
         return tableView
     } ()
/*
    private lazy var minusButton: UIButton = {
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .black)
        let btn = UIButton()
        let image = UIImage(systemName: "minus.square.fill", withConfiguration: homeSymbolConfiguration)
        btn.setImage(image, for: .normal)
        btn.tintColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        btn.isUserInteractionEnabled = true

        return btn
    }()
    
    private lazy var plusButton: UIButton = {
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .black)
        let btn = UIButton()
        let image = UIImage(systemName: "plus.square.fill", withConfiguration: homeSymbolConfiguration)
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        btn.isUserInteractionEnabled = true

        return btn
    }()
    
    @objc func didTapPlusButton(sender: UIButton)
    {
        if numberOfTeams != 10 {
            numberOfTeams += 1
            self.tableView.reloadData()
            names.append("Команда \(numberOfTeams)")
        }
        if numberOfTeams > 2 {
            minusButton.tintColor = .black
        }
        if numberOfTeams == 10 {
            plusButton.tintColor = .gray
        } else {
            plusButton.tintColor = .black
        }
    }
    
    @objc func didTapMinusButton(sender: UIButton)
    {
        if numberOfTeams != 2 {
            numberOfTeams -= 1
            self.tableView.reloadData()
            names.removeLast()
        }
        if numberOfTeams == 9 {
            plusButton.tintColor = .black
        }
        if numberOfTeams == 2 {
            minusButton.tintColor = .gray
        }
    }
*/
    private lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("ПОЕХАЛИ", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 16
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
//    private lazy var backButton: UIButton = {
//        let btn = UIButton()
//        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40)
//        let image = UIImage(systemName: "chevron.left", withConfiguration: homeSymbolConfiguration)
//        btn.setImage(image, for: .normal)
//        btn.tintColor = .black
//        btn.translatesAutoresizingMaskIntoConstraints = false
//
//        return btn
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(self.nextButton)
        addSubview(self.teamsLabel)
//        addSubview(self.minusButton)
//        addSubview(self.plusButton)
        addSubview(self.scoreTableView)
//        addSubview(self.backButton)
        
        
        NSLayoutConstraint.activate([
            
            self.nextButton.heightAnchor.constraint(equalToConstant: 66),
            self.nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.teamsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.teamsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 35),
            
//            self.minusButton.trailingAnchor.constraint(equalTo: self.centerXAnchor),
//            self.minusButton.heightAnchor.constraint(equalToConstant: 40),
//            self.minusButton.widthAnchor.constraint(equalToConstant: 40),
//            self.minusButton.topAnchor.constraint(equalTo: teamsLabel.bottomAnchor, constant: 16),
//            
//            self.plusButton.leadingAnchor.constraint(equalTo: self.centerXAnchor),
//            self.plusButton.heightAnchor.constraint(equalToConstant: 40),
//            self.plusButton.widthAnchor.constraint(equalToConstant: 40),
//            self.plusButton.topAnchor.constraint(equalTo: teamsLabel.bottomAnchor, constant: 16),
            
            self.scoreTableView.topAnchor.constraint(equalTo: self.teamsLabel.bottomAnchor, constant: 16),
            self.scoreTableView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -16),
            self.scoreTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scoreTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
//            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
//            self.backButton.heightAnchor.constraint(equalToConstant: 40),
//            self.backButton.widthAnchor.constraint(equalToConstant: 40),
//            self.backButton.centerYAnchor.constraint(equalTo: self.teamsLabel.centerYAnchor)
            
        ])
    }
}

extension ScoreView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        
        cell.teamLabel.text = names[indexPath.section]
        cell.teamLabel.textColor = .white
        
        let rest = indexPath.section % 3
        
        if rest == 0 {
            cell.myView.backgroundColor = UIColor(named: "RoyalBlueColor")
        } else if rest == 1 {
            cell.myView.backgroundColor = UIColor(named: "DarkPurpleColor")
        } else if rest == 2 {
            cell.myView.backgroundColor = UIColor(named: "OrangeColor")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66+16
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfTeams
    }
    
}
