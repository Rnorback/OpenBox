//
//  Light.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class LightButton: UIButton {
    
    private(set) var puzzleId:PuzzleId
    var onClick:(()->Void) = {}
    let duration:TimeInterval = 0.2
    
    init(gridPos:GridPosition, color:UIColor, puzzleId:PuzzleId) {
        self.puzzleId = puzzleId
        let width = CGFloat(Values.lightWidth)
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        
        self.center = gridPos.center
        self.backgroundColor = color
        self.layer.cornerRadius = 10
        addTargets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTargets() {
        self.addTarget(
            self,
            action: #selector(lightActivated(button:)),
            for: .touchUpInside
        )
        self.addTarget(
            self,
            action: #selector(lightPressed(button:)),
            for: [.touchDown, .touchDragInside]
        )
        self.addTarget(
            self,
            action: #selector(lightReleased(button:)),
            for: .touchDragOutside
        )
    }
    
    @objc fileprivate func lightPressed(button:LightButton) {
        UIView.animate(withDuration: duration) {
            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    @objc fileprivate func lightReleased(button:LightButton) {
        UIView.animate(withDuration: duration) { 
            button.transform = .identity
        }
    }
    
    @objc fileprivate func lightActivated(button:LightButton) {
        UIView.animate(withDuration: duration, animations: {
            button.transform = .identity
        }, completion: { [weak self] (success) in
            //callback here
            self?.onClick()
        })
    }
    
    //listen for starting signal
    //then animate the view to get smaller (just once)
    //listen for ending signal
    //then animate the view to get bigger
    
}
