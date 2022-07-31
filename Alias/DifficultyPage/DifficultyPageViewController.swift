
import UIKit

final class DifficultyPageViewController: CustomViewController {

    override var nameViewControler: String { "УРОВЕНЬ \nСЛОЖНОСТИ" }
    private lazy var difficultyPageViuw = DifficultyPageView()
    private var difficultyChoiceModel = DifficultyChoiceModel()
    private let musicManager = MusicModel()

//    override func loadView() {
//        self.view = self.difficultyPageViuw
//        difficultyPageViuw.delegate = self
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.difficultyPageViuw.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.difficultyPageViuw)
        
        NSLayoutConstraint.activate([
            self.difficultyPageViuw.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.difficultyPageViuw.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.difficultyPageViuw.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.difficultyPageViuw.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor)
        ])
        difficultyPageViuw.delegate = self
        self.updateUI()
    }

    private func updateUI() {
        let update = difficultyChoiceModel.loadJson()
        let image = update?.image
        let color = update?.color
        difficultyPageViuw.choiceImageView.image = UIImage(named: image!)
        difficultyPageViuw.levelLabel.textColor = UIColor(named: color!)
        difficultyPageViuw.levelLabel.text = update?.level
        difficultyPageViuw.descriptionLabel.text = update?.description
        difficultyPageViuw.exampleLabel.text = update?.example
    }
}

// MARK: - TapButtonDelegate

extension DifficultyPageViewController: TapButtonDelegate {
    
    func didForwardChoice() {
        difficultyChoiceModel.makeForwardChoice()
        self.musicManager.playSound(soundName: "Transition")
        self.updateUI()
    }

    func didBackChoice() {
        difficultyChoiceModel.makeBackChoice()
        self.musicManager.playSound(soundName: "Transition")
        self.updateUI()
    }

    func didMakeChoice() {
        // Пуш следующего экрана с передачей слов в соотвествии с уровнем через инициализатор
//        let words = difficultyChoiceModel.getWords()
        let vc = ScoreViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
