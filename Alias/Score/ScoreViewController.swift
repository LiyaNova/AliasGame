
import UIKit


class ScoreViewController: CustomViewController {
    
    private let scoreView = ScoreView()
    
    override func loadView() {
        self.view = self.scoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
