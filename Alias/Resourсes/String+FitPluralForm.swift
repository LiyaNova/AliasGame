
import Foundation

extension String {
    
    static func fitPluralForm(from titles: [String], with count: Int) -> String {
        return titles[fitIndexForValue(count)]
    }
    
    private static func fitIndexForValue(_ value: Int) -> Int {
        let cases = [2, 0, 1, 1, 1, 2]
        let index = (value % 100 > 4 && value % 100 < 20) ? 2 : cases[value % 10 < 5 ? (value % 10) : 5]
        return index
    }
    
}

