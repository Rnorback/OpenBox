//
//  HeartRatePuzzle.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

class HeartRatePuzzle: Puzzle {
    
    let puzzleId: PuzzleId = .heartRate
    private(set) var lightGroup:LightGroup
    
    init() {
        lightGroup = LightGroup(
            positions: [
                GridPosition(x: 5, y: 9),
                GridPosition(x: 6, y: 9),
                GridPosition(x: 7, y: 9)
            ],
            color: Colors.heartRate,
            puzzleId: puzzleId
        )
    }
}
