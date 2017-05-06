import UIKit

class RedBattery: Puzzle {
    var puzzleId: PuzzleId = .redBattery
    var isSolved: Bool {
        return UserDefaults.standard.bool(forKey: puzzleId.rawValue)
    }
    var isRed: Bool {
        return UIDevice.current.batteryLevel <= 0.20 &&
            UIDevice.current.batteryState != .charging &&
            ProcessInfo.processInfo.isLowPowerModeEnabled == false
    }
    
    func checkForSuccess(value:Any? = nil) {
        if isRed {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
