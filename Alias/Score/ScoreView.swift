//
//  ScoreView.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import UIKit

class ScoreView: UIView {

    private var numberOfRound = 2
    var gameButtonTap: (() -> Void)?
    
    private var brain = ScoreBrain()

    private lazy var teamsLabel: UILabel = { // верхний лейбл
        let label = UILabel()
        label.text = "Рейтинг команд"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    lazy var scoreTableView: UITableView = { // табличка
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScoreCell.self, forCellReuseIdentifier: "ScoreCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    } ()
    
    private lazy var roundLabel: UILabel = { // лейбл с номером раунда
        let label = UILabel()
        label.text = "РАУНД \(numberOfRound)"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 32)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var readyToGameLabel: UILabel = { // лейбл - готовятся к игре
        let label = UILabel()
        label.text = "готовятся к игре:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Piazzolla", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var readyToGameTeamLabel: UILabel = { // лейбл - название команды к игре
        let label = UILabel()
        label.text = "КОМАНДА 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 40)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var contentStack: UIStackView = { // стэк с элементами ячейки
        let stack = UIStackView(arrangedSubviews: [self.roundLabel, self.readyToGameLabel, self.readyToGameTeamLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .fillProportionally
        return stack
    }()
    
    public lazy var viewForLbls: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStack)
        return view
    } ()
    
    private lazy var goToGameButton: UIButton = { // кнопка начала игры
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("ПОЕХАЛИ", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 16
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startGame(){
        self.gameButtonTap?()
    }
    
    private func setupUI() {
        
        addSubview(self.teamsLabel)
        addSubview(self.scoreTableView)
        addSubview(viewForLbls)
        addSubview(self.goToGameButton)

        NSLayoutConstraint.activate([
            
            self.teamsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.teamsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 35),
            self.teamsLabel.widthAnchor.constraint(equalToConstant: 150),
            
            self.scoreTableView.topAnchor.constraint(equalTo: self.teamsLabel.bottomAnchor, constant: 16),
            self.scoreTableView.bottomAnchor.constraint(equalTo: self.viewForLbls.topAnchor, constant: -16),
            self.scoreTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scoreTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.viewForLbls.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.viewForLbls.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.viewForLbls.bottomAnchor.constraint(equalTo: goToGameButton.topAnchor, constant: -36),
            self.viewForLbls.heightAnchor.constraint(equalToConstant: 110),
            
            self.contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.goToGameButton.heightAnchor.constraint(equalToConstant: 66),
            self.goToGameButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.goToGameButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.goToGameButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
    }
}

extension ScoreView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as? ScoreCell
        
        if let cell = cell {
           // TO DO обработать колличество ячеек
        let countOfSection = indexPath.section % brain.teamName.count
        cell.myView.backgroundColor = brain.sectionColor(section: countOfSection)
        
        cell.teamLabel.text = brain.team()[indexPath.section]
        cell.scoreLabel.text = String(brain.score()[indexPath.section])
        
        cell.starImage.isHidden = brain.showStar(labelScore: cell.scoreLabel.text ?? "")

        return cell
        }
        return UITableViewCell()
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
        
        return brain.teamName.count
    }
    
}
