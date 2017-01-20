//
//  HeartRatePuzzle.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class HeartRatePuzzle: Puzzle {
    
    private(set) var lightGroup:LightGroup
    
    init() {
        lightGroup = LightGroup(
            positions: [
                GridPosition(x: 5, y: 9),
                GridPosition(x: 6, y: 9),
                GridPosition(x: 7, y: 9)
            ],
            color: UIColor(red: 0.800, green: 0.267, blue: 0.267, alpha: 1.00),
            signal: "ReadingPuzzle"
        )
    }
}
