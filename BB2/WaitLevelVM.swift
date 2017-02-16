//
//  WaitLevelVM.swift
//  BB2
//
//  Created by Rob Norback on 2/15/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

class WaitLevelVM: LevelVM {
    var lightData:[LightVM] = []
    var puzzles:[Puzzle] = [WaitOneDay(), WaitOneHour(), WaitOneMinute()]
    
    init() {
        addLevelLights()
    }
    
    func addLevelLights() {
        let oneMinute = LightVM(
            color: Colors.Wait.light,
            center: GridPosition(x: 0, y: 0).center,
            puzzleId: .waitOneMinute
        )
        
        let oneHour = LightVM(
            color: Colors.Wait.light,
            center: GridPosition(x: 0, y: 0).center,
            puzzleId: .waitOneHour
        )
        
        let oneDay = LightVM(
            color: Colors.Wait.light,
            center: GridPosition(x: 0, y: 0).center,
            puzzleId: .waitOneDay
        )
        
        lightData.append(contentsOf: [oneDay, oneHour, oneMinute])
    }
}
