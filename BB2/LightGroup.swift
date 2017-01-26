//
//  LightGroup.swift
//  BB2
//
//  Created by Rob Norback on 1/19/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class LightGroup {
    
    private(set) var lights:[LightButton] = []
    private(set) var color:UIColor
    private(set) var positions:[GridPosition]
    private(set) var puzzleId:PuzzleId
    
    init(positions:[GridPosition], color:UIColor, puzzleId:PuzzleId) {
        self.positions = positions
        self.color = color
        self.puzzleId = puzzleId
        setupLights()
    }
    
    func setupLights() {
        for pos in positions {
            let light = LightButton(
                gridPos: pos,
                color: color,
                puzzleId: puzzleId
            )
            lights.append(light)
        }
    }
    
}
