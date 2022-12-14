
import UIKit

class StartMenuViewController: UIViewController {
    
    private let startMenuView = StartMenuView()

    override func loadView() {
        self.view = self.startMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMenuView.rulesMenuButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let vc = RulesViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        startMenuView.newGameButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let vc = TeamsMenuViewController(minNumberOfTeams:2, maxNumberOfTeams: 10)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

