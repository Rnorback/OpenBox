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
    
    var onClick:(()->Void) = {}
    let animationDuration:TimeInterval = 0.2
    private(set) var color:UIColor
    private(set) var puzzleId:PuzzleId
    
    var isLit:Bool {
        didSet {
            updateIllumination()
        }
    }
    
     convenience init(lightVM:LightVM) {
        self.init(center:lightVM.center, color: lightVM.color, puzzleId: lightVM.puzzleId)
    }
    
    init(center:CGPoint, color:UIColor, puzzleId:PuzzleId) {
        self.puzzleId = puzzleId
        self.color = color
        self.isLit = UserDefaults.standard.bool(forKey: puzzleId.rawValue)
        
        let width = CGFloat(Values.lightWidth)
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        
        //light
        self.center = center
        self.layer.cornerRadius = 12
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2
    
        //center dot
        let dotCenter = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let centerDot = Dot(position: dotCenter, color: color)
        self.layer.addSublayer(centerDot)
        
        //add notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LightButton.handle(withNotification:)),
            name: Notification.Name(puzzleId.rawValue),
            object: nil
        )
        
        updateIllumination()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("LightButton deinit")
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name(puzzleId.rawValue),
            object: nil
        )
    }
    
    @objc func handle(withNotification notification:Notification) {
        isLit = true
    }
}

//Mark: - Animations
extension LightButton {
    
    fileprivate func updateIllumination() {
        if isLit {
            light()
        } else {
            unlight()
        }
    }
    
    fileprivate func light() {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.backgroundColor = self?.color
        }
    }
    
    fileprivate func unlight() {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.backgroundColor = UIColor.clear
        }
    }
    
    func shrink() {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func toNormalSize() {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.transform = .identity
        }
    }
    
    func toNormalSizePromise() -> Promise<Void> {
        return Promise { fulfill, reject in
            UIView.animate(withDuration: animationDuration, animations: { [weak self] in
                self?.transform = .identity
            }, completion: { (success) in
                success ? fulfill() : reject(AnimationError.failedToComplete)
            })
        }
    }
}
