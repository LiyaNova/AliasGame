
import UIKit

class RulesViewController: UIViewController {

    private let ruleView = RulesView()
    
    override func loadView() {
        self.view = self.ruleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ruleView.backStartMenuButtonTap = {
            [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }

}
