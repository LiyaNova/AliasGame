//
//  ResultScreenView.swift
//  Alias
//
//  Created by Юлия Филимонова on 29.07.2022.
//

import UIKit

class ResultScreenView: UIView {

    private var scoreDict = ["Команда 2": 8, "Команда 3": 7]
    private var brain = BrainResultScreen()

    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "Ellipse Background")
        return backgroundImage
    }()

    public var teamLabel: UILabel = {
        let teamLabel = UILabel()
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.text = "КОМАНДА 1"
        teamLabel.textAlignment = .center
        teamLabel.textColor = .white
        teamLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return teamLabel
    }()

    private var winLabel: UILabel = {
        let winLabel = UILabel()
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        winLabel.text = "WIN!"
        winLabel.textAlignment = .center
        winLabel.textColor = .black
        winLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return winLabel
    }()

    public var circleLabel: UILabel = {
        let circleLabel = UILabel()
        circleLabel.translatesAutoresizingMaskIntoConstraints = false
        circleLabel.text = "10"
        circleLabel.backgroundColor = .white
        circleLabel.textAlignment = .center
        circleLabel.textColor = .black
        circleLabel.layer.masksToBounds = true
        circleLabel.layer.cornerRadius = 40
        circleLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return circleLabel
    }()

    private let cupImage: UIImageView = {
        let cupImage = UIImageView()
        cupImage.translatesAutoresizingMaskIntoConstraints = false
        cupImage.image = UIImage(named: "Goodies Appreciation")
        return cupImage
    }()

    private lazy var resultTableView: UITableView = {
        let resultTableView = UITableView(frame: self.bounds, style: .plain)
        resultTableView.dataSource = self
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.register(ScoreCell.self, forCellReuseIdentifier: "ScoreCell")
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        resultTableView.delegate = self
        resultTableView.separatorStyle = .none
        resultTableView.backgroundColor = .white
        return resultTableView
    } ()

    private lazy var bottomButton: UIButton = {
       let bottomButton = UIButton()
       bottomButton.translatesAutoresizingMaskIntoConstraints = false
       bottomButton.backgroundColor = .black
       bottomButton.setTitle("Новая игра", for: .normal)
       bottomButton.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
       bottomButton.titleLabel?.textColor = .white
       bottomButton.layer.cornerRadius = 16
       bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
       return bottomButton
   }()

    @objc private func didTapBottomButton() {
        print("Делегат или замыкание для контроллера?А потом новая игра)")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        [self.backgroundImage,
         self.teamLabel,
         self.winLabel,
         self.circleLabel,
         self.cupImage,
         self.resultTableView,
         self.bottomButton].forEach { self.addSubview($0)}

        NSLayoutConstraint.activate([

            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImage.heightAnchor.constraint(equalToConstant: 470),

            self.teamLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 33),
            self.teamLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.teamLabel.heightAnchor.constraint(equalToConstant: 30),

            self.winLabel.topAnchor.constraint(equalTo: self.teamLabel.bottomAnchor, constant: 10),
            self.winLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.winLabel.heightAnchor.constraint(equalToConstant: 30),

            self.circleLabel.topAnchor.constraint(equalTo: self.winLabel.bottomAnchor, constant: 15),
            self.circleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.circleLabel.heightAnchor.constraint(equalToConstant: 80),
            self.circleLabel.widthAnchor.constraint(equalToConstant: 80),

            self.cupImage.topAnchor.constraint(equalTo: self.circleLabel.bottomAnchor, constant: 10),
            self.cupImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.cupImage.bottomAnchor.constraint(equalTo: self.backgroundImage.bottomAnchor, constant: -5),

            self.resultTableView.topAnchor.constraint(equalTo: self.backgroundImage.bottomAnchor, constant: 16),
            self.resultTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.resultTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.resultTableView.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor, constant: -16),

            self.bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -11),
            self.bottomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.bottomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.bottomButton.heightAnchor.constraint(equalToConstant: 66)

        ])
    }

}

//MARK: -

extension ResultScreenView: UITableViewDataSource, UITableViewDelegate {

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
        return scoreDict.count
    }

}
