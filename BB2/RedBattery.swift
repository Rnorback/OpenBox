//
//  RedBattery.swift
//  BB2
//
//  Created by Rob Norback on 2/20/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

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
    
    func checkForSuccess(value:Any?) {
        if isRed {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
