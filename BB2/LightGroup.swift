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
        addTargets()
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

//MARK: - Targets
extension LightGroup {
    
    func addTargets() {
        for light in lights {
            light.addTarget(
                self,
                action: #selector(lightActivated(button:)),
                for: .touchUpInside
            )
            light.addTarget(
                self,
                action: #selector(lightPressed(button:)),
                for: [.touchDown, .touchDragInside]
            )
            light.addTarget(
                self,
                action: #selector(lightReleased(button:)),
                for: .touchDragOutside
            )
        }
    }
    
    @objc fileprivate func lightPressed(button:LightButton) {
        for light in lights {
            light.shrink()
        }
    }
    
    @objc fileprivate func lightReleased(button:LightButton) {
        for light in lights {
            light.returnToNormal()
        }
    }
    
    @objc fileprivate func lightActivated(button:LightButton) {
        button.activate()
    }
}
