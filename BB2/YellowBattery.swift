import UIKit

class YellowBattery: Puzzle {
    var puzzleId: PuzzleId = .yellowBattery
    var isSolved: Bool {
        return UserDefaults.standard.bool(forKey: puzzleId.rawValue)
    }
    var isYellow: Bool {
        return ProcessInfo.processInfo.isLowPowerModeEnabled == true
    }
    
    func checkForSuccess(value:Any? = nil) {
        if isYellow {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
