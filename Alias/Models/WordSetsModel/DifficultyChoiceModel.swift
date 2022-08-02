
import UIKit

class DifficultyChoiceModel {

    private var difficultyArray = [WordSetsModel]()
    private var choice = 0

    func loadJson() -> DifficultyPage? {
        guard let url = Bundle.main.url(forResource: "SetWords", withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(WordSetsModels.self, from: data)

            self.difficultyArray = jsonData.level

            let level = jsonData.level[self.choice].title
            let image = jsonData.level[self.choice].image
            let color = jsonData.level[self.choice].color
            let description = jsonData.level[self.choice].description
            let example = jsonData.level[self.choice].example
            let words = jsonData.level[self.choice].words
            
            let difficulty = DifficultyPage(
                image: image,
                level: level,
                color: color,
                description: description,
                example: example,
                words: words
            )
            return difficulty
        } catch {
            print("error:\(error)")
        }
        return nil
    }

    func makeForwardChoice() {
        if self.choice < self.difficultyArray.count - 1 {
            self.choice += 1
        }
    }

    func makeBackChoice() {
        if self.choice == self.difficultyArray.count - 1 && self.choice >= 0 {
            self.choice -= 1
        } else  {
            self.choice = 0
        }
    }

    func getWords() -> [String] {
        self.difficultyArray[self.choice].words
    }

}
