
import UIKit

class ResultScreenViewController: UIViewController {
    
    private let finalists: [Team]
    
//    private let alertManager = AlertManager()
    let resultScreenView = ResultScreenView()
    
    init(finalists: [Team]) {
        self.finalists = finalists
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.resultScreenView
 //       resultScreenView.delegate = self
        
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
        
        print("finalists: \(self.finalists)")
    }
       
}

//MARK: - PresentAlertDelegate
////Пуш алерта при нажатии на кубок
//extension ResultScreenViewController: PresentAlertDelegate {
//    func presentAlert() {
//        //let alert =
//        alertManager.showCustomAlert(with: "Привет", message: "Я алерт", on: self)
//        //showAlert(text: "Леша, привет! Ты большой молодец!)")
//           // present(alert, animated: true)
//    }
//
//    @objc func dismissAlert(){
//        alertManager.dismissAlert()
//    }
//}
