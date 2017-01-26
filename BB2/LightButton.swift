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
//        addTargets()
//        addObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    deinit {
//        removeObservers()
//    }
    
    func shrink() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func returnToNormal() {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.transform = .identity
        }
    }
    
    func activate() {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.transform = .identity
        }, completion: { [weak self] (success) in
            self?.onClick()
        })
    }
}

////MARK: - Notifications
//extension LightButton {
//    
//    fileprivate func addObservers() {
//        for name in [puzzleId.notificationOn, puzzleId.notificationOff] {
//            NotificationCenter.default.addObserver(
//                self,
//                selector: #selector(LightButton.handle(withNotification:)),
//                name: name,
//                object: nil //might want to pass in other lights?
//            )
//        }
//    }
//    
//    fileprivate func removeObservers() {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    @objc fileprivate func handle(withNotification notification:Notification) {
//        
//        switch notification.name {
//        case puzzleId.notificationOn:
//            shrink()
//        case puzzleId.notificationOff:
//            returnToNormal()
//        default:
//            break
//        }
//    }
//    
//    //listen for starting signal
//    //then animate the view to get smaller (just once)
//    //listen for ending signal
//    //then animate the view to get bigger
//    
//}
