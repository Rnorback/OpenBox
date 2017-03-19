//
//  LowPowerLevelVC.swift
//  BB2
//
//  Created by Rob Norback on 2/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class LowPowerLevelVC: UIViewController {
    
    var lowPowerVM:LowPowerLevelVM = LowPowerLevelVM()
    let batteryLightDistance:CGFloat = 70
    var batteryLevel: CGFloat {
        return CGFloat(UIDevice.current.batteryLevel)
    }
    
    var label:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Menu.bg
        UIDevice.current.isBatteryMonitoringEnabled = true
        layoutLights()
        layoutBattery()
        addObservers()
    }
    
    deinit {
        print("deinit")
        removeObservers()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(powerStateChanged), name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: Notification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: Notification.Name.UIDeviceBatteryLevelDidChange, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIDeviceBatteryLevelDidChange, object: nil)
    }
    
    
    func layoutBattery() {
        let batteryImageView:UIImageView = UIImageView(image: #imageLiteral(resourceName: "empty-battery"))

        batteryImageView.center = CGPoint(
            x: view.frame.width/2,
            y: view.frame.height/2 + batteryLightDistance/2
        )
        batteryImageView.layer.zPosition = 1
        
        let zeroBatteryFrame = CGRect(
            x: batteryImageView.frame.origin.x + 2,
            y: batteryImageView.frame.origin.y + 2,
            width: 0,
            height: batteryImageView.frame.height - 4
        )
        
        let insideBatteryFrame = CGRect(
            x: batteryImageView.frame.origin.x + 2,
            y: batteryImageView.frame.origin.y + 2,
            width: (batteryImageView.frame.width - 12) * batteryLevel,
            height: batteryImageView.frame.height - 4
        )
        let yellowView = UIView(frame: zeroBatteryFrame)
        yellowView.backgroundColor = Colors.LowPower.yellow
        yellowView.layer.cornerRadius = 4
        view.addSubview(yellowView)
        view.addSubview(batteryImageView)
        
        UIView.animate(withDuration: 1) {
            yellowView.frame = insideBatteryFrame
        }
    }
    
    func layoutLights() {
        for lightVM in lowPowerVM.lightData {
            let light = LightButton(lightVM: lightVM)
            light.center = CGPoint(
                x: view.frame.width/2,
                y: view.frame.height/2 - batteryLightDistance/2
            )
            view.addSubview(light)
            light.addTarget(self, action: #selector(lightPressed), for: .touchUpInside)
        }
    }
}

//MARK: - Notification Handling
extension LowPowerLevelVC {
    
    func lightPressed() {
        print("Light pressed")
        
    }
    
    func batteryStateDidChange(_ notification: NSNotification){
        // The stage did change: plugged, unplugged, full charge...
        
        if UIDevice.current.batteryState == .charging {
            //green
        }
    }
    
    func batteryLevelDidChange(_ notification: NSNotification){
        // The battery's level did change (98%, 99%, ...)
        
        
        if UIDevice.current.batteryLevel <= 20.0 {
            //red
        }
    }
    
    func willResignActive(_ notification: NSNotification) {
        
        if UIDevice.current.batteryLevel > 20.0 && UIDevice.current.batteryState != .charging {
            //white
        }
    }
    
    func powerStateChanged(_ notification: NSNotification) {
        
        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            //yellow
        }
        for puzzle in lowPowerVM.puzzles {
            let isPowerStateChanged = true
            puzzle.checkForSuccess(value: isPowerStateChanged)
        }
    }
}
