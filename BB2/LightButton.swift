//
//  Light.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit
import PromiseKit

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
        self.layer.cornerRadius = 12
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shrink() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func toNormalSize() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.transform = .identity
        }
    }
    
    func toNormalSizePromise() -> Promise<Void> {
        return Promise { fulfill, reject in
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.transform = .identity
            }, completion: { (success) in
                success ? fulfill() : reject(AnimationError.failedToComplete)
            })
        }
    }
}
