import Foundation

class ReadLastStanzaBackward: Puzzle {
    var puzzleId: PuzzleId = .readLastStanzaBackward
    var isSolved: Bool {
        return UserDefaults.standard.bool(forKey: puzzleId.rawValue)
    }
    
    func checkForSuccess(value:Any?) {
        if false {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
