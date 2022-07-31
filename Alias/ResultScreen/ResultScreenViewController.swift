
import UIKit

class ResultScreenViewController: UIViewController {

    let resultScreenView = ResultScreenView()

    override func loadView() {
        self.view = self.resultScreenView
        resultScreenView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
       
}

//MARK: - PresentAlertDelegate
//Пуш алерта при нажатии на кубок
extension ResultScreenViewController: PresentAlertDelegate {
    func presentAlert() {
        let alert = AlertManager().showAlert(text: "Леша, привет! Ты большой молодец!)")
        present(alert, animated: true)
    }
}
