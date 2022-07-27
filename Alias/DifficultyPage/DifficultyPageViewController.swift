//
//  DifficultyPageViewController.swift
//  Alias
//
//  Created by Юлия Филимонова on 27.07.2022.
//

import UIKit

class DifficultyPageViewController: UIViewController {

    private let difficultyPageViuw = DifficultyPageView()
    private let difficultyChoiceModel = DifficultyChoiceModel()

    override func loadView() {
        self.view = difficultyPageViuw
        difficultyPageViuw.delegate = self

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    

}

// MARK: -
extension DifficultyPageViewController: TapButtonDelegate {
    func didForwardChoice(image: UIImageView, description: UIImageView, level: UILabel) {
        print("Сменить уровень - вперед")
    }

    func didBackChoice(image: UIImageView, description: UIImageView, level: UILabel) {
        print("Сменить уровень - назад")
    
    }

    func didMakeChoice() {
        // Для пуша следующего экрана
        print("Сменить экран")
    }


}
