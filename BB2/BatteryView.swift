//
//  BatteryView.swift
//  BB2
//
//  Created by Rob Norback on 3/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class BatteryView: UIView {
    
    private(set) var batteryImageView:UIImageView = UIImageView(image: #imageLiteral(resourceName: "empty-battery"))
    private(set) var fillView:UIView = UIView()
    
    private(set) var puzzleId:PuzzleId
    
    var batteryLevel: CGFloat {
        return CGFloat(UIDevice.current.batteryLevel)
    }
    
    init(puzzleId:PuzzleId) {
        self.puzzleId = puzzleId
        super.init(frame: batteryImageView.frame)
        
        batteryImageView.center = CGPoint(
            x: self.frame.width/2,
            y: self.frame.height/2
        )
        
        batteryImageView.layer.zPosition = 1
        
        let zeroBatteryLevelFrame = CGRect(
            x: batteryImageView.frame.origin.x + 2,
            y: batteryImageView.frame.origin.y + 2,
            width: 0,
            height: batteryImageView.frame.height - 4
        )
        
        fillView = UIView(frame: zeroBatteryLevelFrame)
        fillView.backgroundColor = getBatteryColor(puzzleId: puzzleId)
        fillView.layer.cornerRadius = 4
        self.addSubview(fillView)
        self.addSubview(batteryImageView)
        
        if UserDefaults.standard.bool(forKey: puzzleId.rawValue) {
            animateFill()
        }
        
        //add notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(BatteryView.handle(withNotification:)),
            name: Notification.Name(puzzleId.rawValue),
            object: nil
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getBatteryColor(puzzleId:PuzzleId) -> UIColor? {
        switch puzzleId {
        case .redBattery:
            return Colors.Battery.red
        case .greenBattery:
            return Colors.Battery.green
        case .yellowBattery:
            return Colors.Battery.yellow
        case .whiteBattery:
            return Colors.Battery.white
        default:
            return nil
        }
    }
    
    @objc func handle(withNotification notification:Notification) {
        animateFill()
    }
    
    func animateFill() {
        
        let currentBatteryLevelFrame = CGRect(
            x: batteryImageView.frame.origin.x + 2,
            y: batteryImageView.frame.origin.y + 2,
            width: (batteryImageView.frame.width - 12) * batteryLevel,
            height: batteryImageView.frame.height - 4
        )
        
        UIView.animate(withDuration: 1) {
            self.fillView.frame = currentBatteryLevelFrame
        }
    }
    
}
