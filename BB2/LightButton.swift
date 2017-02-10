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
    
    enum LightState {
        case lit
        case unlit
    }
    
    var onClick:(()->Void) = {}
    let duration:TimeInterval = 0.2
    private(set) var color:UIColor
    var gridPos:GridPosition
    
    var lightState:LightState {
        didSet {
            updateIllumination()
        }
    }
    
    init(gridPos:GridPosition, color:UIColor, lightState:LightState = .unlit) {
        self.gridPos = gridPos
        self.lightState = lightState
        self.color = color
        let width = CGFloat(Values.lightWidth)
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        
        self.center = gridPos.center
        self.layer.cornerRadius = 12
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2
    
        let dotCenter = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let centerDot = Dot(position: dotCenter, color: color)
        self.layer.addSublayer(centerDot)
        
        updateIllumination()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func light() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.backgroundColor = self?.color
        }
    }
    
    fileprivate func unlight() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.backgroundColor = UIColor.clear
        }
    }
    
    fileprivate func updateIllumination() {
        switch lightState {
        case .lit:
            self.light()
        case .unlit:
            self.unlight()
        }
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

extension LightButton: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = LightButton(gridPos: gridPos, color: color, lightState: lightState)
        return copy
    }
}
