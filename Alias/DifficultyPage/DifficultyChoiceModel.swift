
import UIKit

struct DifficultyChoiceModel {

    private let difficulty = [DifficultyPage(image: "Goodies Blush",
                                             level: "Начальный",
                                             color: "PersianBlueColor",
                                             description: """
           Набор из оригинальной настольной игры. Содержит слова и словосочетания разной сложности.
        \nПримеры из набора:  чулки, притеснять, центр города
        """),
                              DifficultyPage(image: "Goodies Ok-1",
                                             level: "Средний",
                                             color: "DarkPurpleColor",
                                             description: """
        Описание: Простые слова, быстрый темп игры.
        \nПримеры из набора:  гильза, сантиметр, баскетбол
        """),
                              DifficultyPage(image: "Goodies Fire",
                                             level: "Профи",
                                             color: "SignalOrangeColor",
                                             description: """
        Иногда нужно приложить усилия, чтобы правильно объяснить эти слова.
        \nПримеры из набора:  католицизм, бурбон, автоматчик
        """)
    ]

    private var choice = 0

    mutating func makeForwardChoice() {
        if choice < difficulty.count - 1 {
            choice += 1
        }
    }

    mutating func makeBackChoice() {
        if choice == difficulty.count - 1 && choice >= 0 {
            choice -= 1
        } else  {
            choice = 0
        }
    }

    func getLevelText() -> String {
        return difficulty[choice].level

    }

    func getImage() -> String {
        return difficulty[choice].image

    }

    func getColor() -> String {
        return difficulty[choice].color

    }

    func getDescription() -> String {
        return difficulty[choice].description

    }

}

