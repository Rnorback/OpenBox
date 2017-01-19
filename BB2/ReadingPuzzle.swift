//
//  ReadingPuzzle.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class ReadingPuzzle: Puzzle {
    
    private(set) var lights:[Light] = []
    private(set) var lightColor:UIColor = UIColor(red: 0.953, green: 0.647, blue: 0.212, alpha: 1.00)
    private(set) var lightPositions:[GridPosition] = [
        GridPosition(x: 7, y: 10),
        GridPosition(x: 7, y: 11),
        GridPosition(x: 7, y: 12),
        GridPosition(x: 7, y: 13)
    ]
    
    init() {
        setupLights()
    }
    
    func setupLights() {
        for lightPos in lightPositions {
            let light = Light(
                gridPos: lightPos,
                color: lightColor
            )
            lights.append(light)
        }
    }
}
