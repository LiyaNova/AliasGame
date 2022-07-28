//
//  DifficultyPageViewController.swift
//  Alias
//
//  Created by Юлия Филимонова on 27.07.2022.
//

import UIKit

class DifficultyPageViewController: UIViewController {

    private let difficultyPageViuw = DifficultyPageView()
    private var difficultyChoiceModel = DifficultyChoiceModel()

    override func loadView() {
        self.view = self.difficultyPageViuw
        difficultyPageViuw.delegate = self

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()

        //Настроен навигейшн на страницу, для удобства, потом можно убрать
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }

    private func updateUI() {
        let image = difficultyChoiceModel.getImage()
        let color = difficultyChoiceModel.getColor()

        difficultyPageViuw.choiceImageView.image = UIImage(named: image)
        difficultyPageViuw.levelLabel.textColor = UIColor(named: color)
        difficultyPageViuw.levelLabel.text = difficultyChoiceModel.getLevelText()
        difficultyPageViuw.descriptionLabel.text = difficultyChoiceModel.getDescription()
    }

}

// MARK: -
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
        // Для пуша следующего экрана
        print("Сменить экран")
    }

}
