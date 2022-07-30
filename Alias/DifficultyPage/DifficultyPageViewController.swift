//
//  DifficultyPageViewController.swift
//  Alias
//
//  Created by Юлия Филимонова on 27.07.2022.
//

import UIKit

final class DifficultyPageViewController: UIViewController {

    private let difficultyPageViuw = DifficultyPageView()
    private var difficultyChoiceModel = DifficultyChoiceModel()

    override func loadView() {
        self.view = self.difficultyPageViuw
        difficultyPageViuw.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.updateUI()
    }

    func didBackChoice() {
        difficultyChoiceModel.makeBackChoice()
        self.updateUI()
    }

    func didMakeChoice() {
        print("Сменить экран")
        // Пуш следующего экрана с передачей слов в соотвествии с уровнем через инициализатор
        let words = difficultyChoiceModel.getWords()
        let gs = GameScreenViewController(words: words)
        navigationController?.pushViewController(gs, animated: true)
    }

}
