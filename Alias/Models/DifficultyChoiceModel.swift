
import UIKit

struct DifficultyChoiceModel {

    private var difficultyArray = [WordSetsModel]()
    private var choice = 0

    mutating func loadJson() -> DifficultyPage? {
        if let url = Bundle.main.url(forResource: "GameData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(WordSetsModels.self, from: data)

                difficultyArray = jsonData.level

                let level = jsonData.level[choice].title
                let image = jsonData.level[choice].image
                let color = jsonData.level[choice].color
                let description = jsonData.level[choice].description
                let example = jsonData.level[choice].example
                let words = jsonData.level[choice].words
                let difficulty = DifficultyPage(image: image, level: level, color: color,
                                                description: description, example: example, words: words)
                return difficulty
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    mutating func makeForwardChoice() {
        if choice < difficultyArray.count - 1 {
            choice += 1
        }
    }

    mutating func makeBackChoice() {
        if choice == difficultyArray.count - 1 && choice >= 0 {
            choice -= 1
        } else  {
            choice = 0
        }
    }

    func getWords() -> [String] {
        return difficultyArray[choice].words
    }

}
