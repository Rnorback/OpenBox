//
//  HeartRatePuzzle.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class HeartRatePuzzle: Puzzle {
    
    private(set) var lights:[Light] = []
    private(set) var lightColor:UIColor = UIColor(red: 0.800, green: 0.267, blue: 0.267, alpha: 1.00)
    private(set) var lightPositions:[GridPosition] = [
        GridPosition(x: 5, y: 9),
        GridPosition(x: 6, y: 9),
        GridPosition(x: 7, y: 9)
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
