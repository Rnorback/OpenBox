import UIKit

class WhiteBattery: Puzzle {
    var puzzleId: PuzzleId = .whiteBattery
    var isSolved: Bool {
        return UserDefaults.standard.bool(forKey: puzzleId.rawValue)
    }
    var isWhite: Bool {
        return UIDevice.current.batteryLevel > 0.20 &&
            UIDevice.current.batteryState != .charging &&
            ProcessInfo.processInfo.isLowPowerModeEnabled == false
    }
    
    func checkForSuccess(value:Any? = nil) {
        if isWhite {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
