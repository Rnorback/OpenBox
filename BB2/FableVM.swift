//
//  FableLevelVM.swift
//  BB2
//
//  Created by Rob Norback on 2/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

class FableVM: LevelVM {
    var lightData: [LightVM] = []
    var puzzles: [Puzzle] = [
        ReadFirstStanza()
    ]
    
    init() {
        prepLightData()
    }
    
    func prepLightData() {
        for puzzle in puzzles {
            let lightVM = LightVM(
                color: Colors.Fable.light,
                center: GridPosition(x: 0, y: 0).center,
                puzzleId: puzzle.puzzleId
            )
            
            lightData.append(lightVM)
        }
    }
}
