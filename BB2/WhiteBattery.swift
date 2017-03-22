//
//  WhiteBattery.swift
//  BB2
//
//  Created by Rob Norback on 2/20/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

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
    
    func checkForSuccess(value isBatterModeChanged:Any?) {
        guard let isBatterModeChanged = isBatterModeChanged as? Bool else {
            print("\(type(of:self)): Not passed a valid boolean")
            return
        }
        
        if isBatterModeChanged {
            NotificationCenter.default.post(
                name: Notification.Name(puzzleId.rawValue),
                object: nil
            )
            UserDefaults.standard.set(true, forKey: puzzleId.rawValue)
        }
    }
}
