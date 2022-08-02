
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
        
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(makeBubble), userInfo: nil, repeats: true)
        
    }
    
    private func getData(){
        let baseURL = api.baseURL
        networkManager.fetchData(url: baseURL)
        networkManager.delegate = self
    }
    
    @objc func makeBubble() {
        let bubbleImage = UIImage(named: "Goodies Appreciation")
        let bubbleImageView = UIImageView(image: bubbleImage)
        bubbleImageView.alpha = 0.8
        let screenSize = UIScreen.main.bounds
        let bubbleWidth = Int(60)
        let bubbleHeight = Int(60)
        let randomX = arc4random_uniform(UInt32(screenSize.width + 1))
        bubbleImageView.frame = CGRect(x: Int(randomX) - Int(Double(bubbleWidth) * 0.5), y: Int(screenSize.height) + bubbleHeight, width: bubbleWidth, height: bubbleHeight)
        view.addSubview(bubbleImageView)
        UIView.animate(withDuration: 13.0, animations: {

            bubbleImageView.center = CGPoint(x: bubbleImageView.center.x, y: CGFloat(-bubbleHeight))
        }) { (finished: Bool) in
            bubbleImageView.removeFromSuperview()
        }
        UIGraphicsEndImageContext()
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

