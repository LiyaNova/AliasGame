
import UIKit

class JokeViewController: UIViewController {
    
    private let jokeView = JokeView()
    private let networkManager = NetworkManager()
    private let api = Api()
    private var jokes: JokeModel?

    override func loadView() {
        self.view = self.jokeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        jokeView.newGameButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let vc = StartMenuViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    private func getData(){
        let baseURL = api.baseURL
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
}

extension JokeViewController: NetworkManagerDelegate {
    func showData(results: JokeModel) {
        let jokes = results
        if jokes != nil {
        jokeView.jokeLabel.text = "\(jokes.setup)\n\n \(jokes.punchline)"
        } else {
            jokeView.jokeLabel.text = "Шутки нет :("
        }
    }
}

