//
//  CoolPlacesPuzzle.swift
//  BB2
//
//  Created by Rob Norback on 1/26/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

class CoolPlacesPuzzle: Puzzle {
    
    let puzzleId: PuzzleId = .coolPlaces
    var lightGroup: LightGroup
    
    init() {
        lightGroup = LightGroup(
            positions: [
                GridPosition(x: 5, y: 10),
                GridPosition(x: 5, y: 11),
                GridPosition(x: 6, y: 10),
                GridPosition(x: 6, y: 11)
            ],
            color: Colors.coolPlaces,
            puzzleId: puzzleId
        )
    }
}
