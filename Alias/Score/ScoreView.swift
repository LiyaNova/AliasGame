//
//  ScoreView.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import UIKit

class ScoreView: UIView {
    
    var scoreDict = ["Команда 2": 10, "Команда 3": 8, "Команда 1": 7]
    
    private lazy var teamsLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинг команд"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = .gray
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
        tableView.backgroundColor = .red
        return tableView
    } ()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(self.teamsLabel)
        addSubview(self.scoreTableView)
        addSubview(self.nextButton)
        
        NSLayoutConstraint.activate([
            
            self.teamsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.teamsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 35),
            self.teamsLabel.widthAnchor.constraint(equalToConstant: 150),
            
            self.scoreTableView.topAnchor.constraint(equalTo: self.teamsLabel.bottomAnchor, constant: 16),
            self.scoreTableView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -16),
            self.scoreTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scoreTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.nextButton.heightAnchor.constraint(equalToConstant: 66),
            self.nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
    }
}

extension ScoreView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        
        let team = [String](scoreDict.keys)
        let score = [Int](scoreDict.values)
        cell.teamLabel.text = team[indexPath.section]
        cell.scoreLabel.text = String(score[indexPath.section])
        
        
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
        return scoreDict.count
    }
    
}
