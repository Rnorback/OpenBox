//
//  LowPowerLevelVM.swift
//  BB2
//
//  Created by Rob Norback on 2/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

class LowPowerLevelVM: LevelVM {
    var lightData: [LightVM] = []
    var puzzles: [Puzzle] = [LowPower()]
    
    init() {
        addLevelLights()
    }
    
    fileprivate func addLevelLights() {
        for puzzle in puzzles {
            let lightVM = LightVM(
                color: Colors.LowPower.light,
                center: GridPosition(x: 0, y: 0).center,
                puzzleId: puzzle.puzzleId
            )
            
            lightData.append(lightVM)
        }
    }

}
