//
//  WaitPuzzle.swift
//  BB2
//
//  Created by Rob Norback on 2/7/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

class WaitPuzzle: PuzzleGroup {
    
    let puzzleId:PuzzleId = .wait
    private(set) var lightGroup:LightGroup
    
    init() {
        lightGroup = LightGroup(
            positions: [
                GridPosition(x: 5, y: 11),
                GridPosition(x: 5, y: 12),
                GridPosition(x: 5, y: 13),
            ],
            color: Colors.wait,
            puzzleId: puzzleId
        )
    }
}
