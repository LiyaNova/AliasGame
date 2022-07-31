
import Foundation

import UIKit

class TeamsMenuViewController: CustomViewController {
    
    private let alertManager = AlertManager()
    override var nameViewControler: String { "КОМАНДЫ" }
    let minNumberOfTeams: Int
    let maxNumberOfTeams: Int
    
    private lazy var teamsMenuView = TeamsMenuView(
        minNumberOfTeams: self.minNumberOfTeams,
        maxNumberOfTeams: self.maxNumberOfTeams,
        teams: self.teams
    )
    
    var teams: [Team] = [] {
        didSet {
            self.teamsMenuView.teams = self.teams
        }
    }
    
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

        teamsMenuView.delegate = self //подписка на делегата
        self.teamsMenuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.teamsMenuView)
        
        NSLayoutConstraint.activate([
            self.teamsMenuView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.teamsMenuView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.teamsMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.teamsMenuView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor)
        ])
        
        let firstTwoTeams = Teams().makeTeams(count: minNumberOfTeams)
        self.teamsMenuView.teams = firstTwoTeams
        self.teams = firstTwoTeams
        
        teamsMenuView.addNewTeam = {
            [weak self] in
            guard let self = self else { return }
            
            if self.teamsMenuView.teams.count != self.maxNumberOfTeams {
                self.teams.append(Teams().makeNewTeam())
            }
        }
        teamsMenuView.deleteTeam = {
            [weak self] in
            guard let self = self else { return }
            
            if self.teamsMenuView.teams.count != self.minNumberOfTeams {
                self.teams.removeLast()
            }
        }
        
        teamsMenuView.nextVC = {
            [weak self] in
            guard let self = self else { return }
            
            let vc = DifficultyPageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            print(self.teams)
        }
    }
}

//MARK: - PresentAlertDelegate
//Пуш алерта
extension TeamsMenuViewController: PresentAlertDelegate {
    func presentAlert() {
        //let alert =
        alertManager.showCustomAlert(with: "Привет", message: "Я алерт", on: self)
        //showAlert(text: "Леша, привет! Ты большой молодец!)")
           // present(alert, animated: true)
    }

    @objc func dismissAlert(){
        alertManager.dismissAlert()
    }
}
