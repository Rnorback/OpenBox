import Foundation

class WaitOneMinute: Puzzle {
    var puzzleId: PuzzleId = .waitOneMinute
    var isSolved: Bool {
        return UserDefaults.standard.bool(forKey: puzzleId.rawValue)
    }
    
    func checkForSuccess(value secondsPassed:Any?) {
        guard let secondsPassed = secondsPassed as? Int else {
            print("\(type(of:self)): Not passed a valid integer")
            return
        }
        
        if secondsPassed == 60 {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
