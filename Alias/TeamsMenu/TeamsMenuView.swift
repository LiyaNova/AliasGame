
import UIKit

class TeamsMenuView: UIView {

    weak var delegate: PresentAlertDelegate? //Протокол для пуша алерта (ищи в файле ResultScreenView). Может вынесем протоколы в отдельный фаил?
    
    let minNumberOfTeams: Int
    let maxNumberOfTeams: Int

    // Переменная куда приходит номер выбранной ячекий
    var sectionToRename: Int?

    var teams: [Team] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var addNewTeam :(() -> Void)?
    var deleteTeam :(() -> Void)?
    var nextVC :(() -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
         tableView.dataSource = self
         tableView.backgroundColor = .white
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
         tableView.delegate = self
         tableView.separatorStyle = .none
         return tableView
     } ()
    
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
    
    private lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("Далее", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 16
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return btn
    }()
    
    init(minNumberOfTeams: Int, maxNumberOfTeams: Int, teams: [Team], frame: CGRect = .zero) {
        self.minNumberOfTeams = minNumberOfTeams
        self.maxNumberOfTeams = maxNumberOfTeams
        self.teams = teams
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(self.nextButton)
        addSubview(self.minusButton)
        addSubview(self.plusButton)
        addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            
            self.nextButton.heightAnchor.constraint(equalToConstant: 66),
            self.nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),

            self.minusButton.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.minusButton.heightAnchor.constraint(equalToConstant: 40),
            self.minusButton.widthAnchor.constraint(equalToConstant: 40),
            self.minusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            self.plusButton.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            self.plusButton.heightAnchor.constraint(equalToConstant: 40),
            self.plusButton.widthAnchor.constraint(equalToConstant: 40),
            self.plusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            self.tableView.topAnchor.constraint(equalTo: self.plusButton.bottomAnchor, constant: 16),
            self.tableView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -16),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    @objc func didTapPlusButton(sender: UIButton) {
        self.addNewTeam?()
        self.changePlusMinusButtonColor()
        self.tableView.reloadData()
    }
    
    @objc func didTapMinusButton(sender: UIButton) {
        self.deleteTeam?()
        self.changePlusMinusButtonColor()
        self.tableView.reloadData()
    }
    
    @objc func didTapNextButton() {
        self.nextVC?()
    }

    private func changePlusMinusButtonColor() {
        if teams.count == 2 {
            minusButton.tintColor = .gray
        } else if teams.count == 10 {
            plusButton.tintColor = .gray
        } else {
            plusButton.tintColor = .black
            minusButton.tintColor = .black
        }
    }
}

extension TeamsMenuView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
        
        let team = self.teams[indexPath.section]
        cell.teamLabel.text = team.name
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
        return self.teams.count
    }
//Передает пуш делегату в TeamMenuViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.presentAlert()
        sectionToRename = indexPath.section
    }
}
