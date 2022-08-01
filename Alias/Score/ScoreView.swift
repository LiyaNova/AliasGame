
import UIKit

class ScoreView: UIView {
    var gameButtonTap: (() -> Void)?
    
    var teams: [Team] {
        didSet {
            self.scoreTableView.reloadData()
        }
    }
    
    var numberOfRound: Int {
        didSet {
            self.roundLabel.text = "РАУНД \(self.numberOfRound + 1)"
        }
    }
    
    var playingTeamIndx: Int
    
    private(set) lazy var readyToGameTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "\(teams[playingTeamIndx].name)"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 40)
        label.textAlignment = .center
        return label
    }()

    private lazy var roundLabel: UILabel = {
        let label = UILabel()
        label.text = "РАУНД 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 32)
        label.textAlignment = .center
        return label
    }()
    
    lazy var scoreTableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScoreCell.self, forCellReuseIdentifier: "ScoreCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var readyToGameLabel: UILabel = {
        let label = UILabel()
        label.text = "готовятся к игре:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Piazzolla", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.roundLabel,
            self.readyToGameLabel,
            self.readyToGameTeamLabel
        ])
        
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
        view.addSubview(self.contentStack)
        return view
    } ()
    
    private lazy var goToGameButton: UIButton = {
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
    
    init(teams: [Team], playingTeamIndx: Int, numberOfRound: Int) {
        self.teams = teams
        self.playingTeamIndx = playingTeamIndx
        self.numberOfRound = numberOfRound
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startGame(){
        self.gameButtonTap?()
    }
    
}

private extension ScoreView {
    
    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(self.scoreTableView)
        self.addSubview(self.viewForLbls)
        self.addSubview(self.goToGameButton)
        
        NSLayoutConstraint.activate([
            
            self.scoreTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.scoreTableView.bottomAnchor.constraint(equalTo: self.viewForLbls.topAnchor, constant: -16),
            self.scoreTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scoreTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.viewForLbls.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.viewForLbls.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.viewForLbls.bottomAnchor.constraint(equalTo: self.goToGameButton.topAnchor, constant: -36),
            self.viewForLbls.heightAnchor.constraint(equalToConstant: 110),
            
            self.contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.goToGameButton.heightAnchor.constraint(equalToConstant: 66),
            self.goToGameButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.goToGameButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.goToGameButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
    }
    
}

// MARK: - UITableViewDataSource/Delegate
extension ScoreView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        
        let countOfSection = indexPath.section % 3
        cell.myView.backgroundColor = sectionColor(section: countOfSection)
        let team = self.teams[indexPath.section]
        cell.teamLabel.text = team.name
        cell.scoreLabel.text = String(team.scores)
        cell.starImage.isHidden = showStar(labelScore: cell.scoreLabel.text ?? "")
        
        return cell
    }
    
    private func sectionColor(section: Int)-> UIColor {
        var color: UIColor = .gray
        if section == 0 {
            color = UIColor(named: "RoyalBlueColor") ?? .gray
        } else if section == 1 {
            color = UIColor(named: "DarkPurpleColor") ?? .gray
        } else if section == 2 {
            color =  UIColor(named: "OrangeColor") ?? .gray
        }
        return color
    }
    
    //Заменить количество 10 на данные макисмального колличества очков у команд
    private func showStar(labelScore: String)-> Bool {
        var parametr = true
        if labelScore == String(0) {
            return parametr
        } else if String(10) == labelScore {
            parametr = false
        }
        return parametr
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
        return teams.count
    }
}
