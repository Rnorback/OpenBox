//
//  LightGroup.swift
//  BB2
//
//  Created by Rob Norback on 1/19/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class LightGroup {
    
    private(set) var lights:[Light] = []
    private(set) var color:UIColor
    private(set) var positions:[GridPosition]
    private(set) var signal:String
    
    
    
    init(positions:[GridPosition], color:UIColor, signal:String) {
        self.positions = positions
        self.color = color
        self.signal = signal
        setupLights()
    }
    
    func setupLights() {
        for pos in positions {
            let light = Light(
                gridPos: pos,
                color: color,
                signal: signal
            )
            lights.append(light)
        }
    }

}
