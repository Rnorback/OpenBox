//
//  YellowBattery.swift
//  BB2
//
//  Created by Rob Norback on 2/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class YellowBattery: Puzzle {
    var puzzleId: PuzzleId = .yellowBattery
    var isSolved: Bool {
        return UserDefaults.standard.bool(forKey: puzzleId.rawValue)
    }
    var isYellow: Bool {
        return UIDevice.current.batteryState != .charging &&
            ProcessInfo.processInfo.isLowPowerModeEnabled == true
    }
    
    func checkForSuccess(value:Any?) {
        if isYellow {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
