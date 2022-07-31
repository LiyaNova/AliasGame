
import UIKit

class ScoreViewController: CustomViewController {
    
    override var nameViewControler: String { "УРОВЕНЬ \nСЛОЖНОСТИ" }
    private let scoreView = ScoreView()
    
    
//    override func loadView() {
//        self.view = self.scoreView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scoreView)
        
        NSLayoutConstraint.activate([
            self.scoreView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scoreView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scoreView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scoreView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor)
        ])
        
        scoreView.gameButtonTap = {
            [weak self] in
            guard let self = self else { return }
            //Прописала nil в созданный инициализатор, чтобы не ругался
            let vc = GameScreenViewController(words: ["word"])
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}


//    override func backButtonTap() {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
