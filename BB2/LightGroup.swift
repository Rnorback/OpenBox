//
//  LightGroup.swift
//  BB2
//
//  Created by Rob Norback on 1/19/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit
import PromiseKit

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
                color: color
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
                action: #selector(lightPressed),
                for: [.touchDown, .touchDragInside]
            )
            light.addTarget(
                self,
                action: #selector(lightReleased),
                for: [.touchDragOutside, .touchCancel]
            )
        }
    }
    
    @objc fileprivate func lightPressed() {
        for light in lights {
            light.shrink()
        }
    }
    
    @objc fileprivate func lightReleased() {
        for light in lights {
            light.toNormalSize()
        }
    }
    
    @objc fileprivate func lightActivated(button:LightButton) {
        var promises:[Promise<Void>] = []
        for light in lights {
            promises.append(light.toNormalSizePromise())
        }
        
        when(fulfilled: promises).then {
            button.onClick()
        }.catch { (error) in
            guard let error = error as? AnimationError else {
                print("LightGroup Error: Passed an unexpected error type")
                return
            }
            
            print("LightGroup Error: \(error.localizedDescription)")
        }
    }
}
