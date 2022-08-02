
import UIKit

class ResultScreenViewController: UIViewController {
    
    var finalists: [Team]
    
    private lazy var resultScreenView = ResultScreenView(finalists: self.finalists)
    
    init(finalists: [Team]) {
        self.finalists = finalists
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.resultScreenView
        
        resultScreenView.tapImageBtn = {
            [weak self] in
            guard let self = self else { return }
            let vc = JokeViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultScreenView.backStartVC = {
            [weak self] in
            guard let self = self else { return }
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
