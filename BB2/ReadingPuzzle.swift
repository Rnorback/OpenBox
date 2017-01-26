//
//  ReadingPuzzle.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

class ReadingPuzzle: Puzzle {
    
    let puzzleId:PuzzleId = .reading
    private(set) var lightGroup:LightGroup
    
    init() {
        lightGroup = LightGroup(
            positions: [
                GridPosition(x: 7, y: 10),
                GridPosition(x: 7, y: 11),
                GridPosition(x: 7, y: 12),
                GridPosition(x: 7, y: 13)
            ],
            color: Colors.reading,
            puzzleId: puzzleId
        )
    }
}
