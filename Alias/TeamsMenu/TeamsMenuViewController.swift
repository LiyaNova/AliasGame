
import UIKit

class TeamsMenuViewController: CustomViewController {
    
    private let alertManager = AlertForChangeTeamName()
    override var nameViewControler: String { "КОМАНДЫ" }
    let minNumberOfTeams: Int
    let maxNumberOfTeams: Int
    var setOfUsedNames: Set<String> = []
    private let musicManager = MusicModel()
    
    func updateSetOfNames() {
        setOfUsedNames = []
        for i in 0..<self.teams.count {
            setOfUsedNames.insert(self.teams[i].name)
        }
    }
    
    var teams: [Team] = [] {
        didSet {
            self.teamsMenuView.teams = self.teams
            print("Teams from TMVC \(self.teams)")
        }
    }
    
    private lazy var teamsMenuView = TeamsMenuView(
        minNumberOfTeams: self.minNumberOfTeams,
        maxNumberOfTeams: self.maxNumberOfTeams,
        teams: self.teams
    )
    

//    override func loadView() {
//        self.teamsMenuView.customNavBar = self.customNavigationBarView
//        self.view = self.teamsMenuView
//    }
    
    init(minNumberOfTeams: Int, maxNumberOfTeams: Int) {
        self.minNumberOfTeams = minNumberOfTeams
        self.maxNumberOfTeams = maxNumberOfTeams
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertManager.delegate = self //подписка на делегата ренейма команды
        teamsMenuView.delegate = self //подписка на делегата пуша алерта

        self.teamsMenuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.teamsMenuView)
        
        NSLayoutConstraint.activate([
            self.teamsMenuView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.teamsMenuView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.teamsMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.teamsMenuView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor)
        ])
        
        let firstTwoTeams = Teams().makeTeams(count: minNumberOfTeams)
        self.teams = firstTwoTeams
        self.updateSetOfNames()
        
        print("Our News Teams \(firstTwoTeams)")
        
        teamsMenuView.addNewTeam = {
            [weak self] in
            guard let self = self else { return }
            
            var added = true
            self.musicManager.playSound(soundName: "Transition")
            
                if self.teams.count != self.maxNumberOfTeams {
                    while (added) {
                        let newTeam = Teams().makeNewTeam()
                        if !self.setOfUsedNames.contains(newTeam.name) {
                            self.teams.append(newTeam)
                            self.updateSetOfNames()
                            added.toggle()
                    print("Our Teams after add\(self.teams)")
                        }
                    }
            }
        }
    
        teamsMenuView.deleteTeam = {
            [weak self] in
            guard let self = self else { return }
            
            if self.teams.count != self.minNumberOfTeams {

                self.teams.removeLast()
                self.updateSetOfNames()
                print("Our Teams after minus\(self.teams)")
            }
            self.musicManager.playSound(soundName: "Transition")
        }
        
        teamsMenuView.nextVC = {
            [weak self] in
            guard let self = self else { return }
            
            let vc = DifficultyPageViewController()
            vc.teams = self.teams
            print("Our Teams \(self.teams)")
            self.navigationController?.pushViewController(vc, animated: true)

            self.musicManager.playSound(soundName: "Transition")
        }
    }
}

//MARK: - PresentAlertDelegate
//Пуш алерта
extension TeamsMenuViewController: PresentAlertDelegate {
    func presentAlert() {
        alertManager.showAlertChangeTeamName(title: "Как назовем команду?", target: self)
    }
}

//MARK: - NewNameDelegate
//Замена ячейки по индексу - переименование команды
extension TeamsMenuViewController: NewNameDelegate {
    func renameTeam(name: String) {
        guard let index = teamsMenuView.sectionToRename else {return}
        teams.remove(at: index)
        teams.insert(Teams().makeNewTeamName(name: name), at: index)
    }
}

