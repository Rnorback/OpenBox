//
//  GreenBattery.swift
//  BB2
//
//  Created by Rob Norback on 2/20/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class GreenBattery: Puzzle {
    var puzzleId: PuzzleId = .greenBattery
    var isSolved: Bool {
        return UserDefaults.standard.bool(forKey: puzzleId.rawValue)
    }
    var isCharging: Bool {
        return UIDevice.current.batteryState == .charging
    }
    
    func checkForSuccess(value:Any? = nil) {
        if isCharging {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
