//
//  LowPowerLevelVC.swift
//  BB2
//
//  Created by Rob Norback on 2/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class BatteryVC: UIViewController {
    
    var batteryVM:BatteryVM = BatteryVM()
    let horizontalLightBatterySpacing:CGFloat = 100
    var verticalLightSpacing:CGFloat {
        return view.frame.height/CGFloat(batteryVM.puzzles.count)
    }
    
    var label:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Menu.bg
        UIDevice.current.isBatteryMonitoringEnabled = true
        layoutLights()
        layoutBatteries()
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
    
    
    func layoutBatteries() {
        for (index, puzzle) in batteryVM.puzzles.enumerated() {
            let battery = BatteryView(puzzleId: puzzle.puzzleId)
            battery.center = CGPoint(
                x: view.frame.width/2 + horizontalLightBatterySpacing/2,
                y: verticalLightSpacing/2 + verticalLightSpacing * CGFloat(index)
            )
            view.addSubview(battery)
        }
    }

    func layoutLights() {
        for (index,lightVM) in batteryVM.lightData.enumerated() {
            
            let light = LightButton(lightVM: lightVM)
            light.center = CGPoint(
                x: view.frame.width/2 - horizontalLightBatterySpacing,
                y: verticalLightSpacing/2 + verticalLightSpacing * CGFloat(index)
            )
            view.addSubview(light)
            light.addTarget(self, action: #selector(lightPressed), for: .touchUpInside)
        }
    }
}

//MARK: - Notification Handling
extension BatteryVC {
    
    func lightPressed() {
        print("Light pressed")
        
    }
    
    func batteryStateDidChange(_ notification: NSNotification){
        // The stage did change: plugged, unplugged, full charge...
        
        if UIDevice.current.batteryState == .charging {
            //green
            let greenPuzzle = batteryVM.puzzles.filter{$0.puzzleId == .greenBattery}.first
            greenPuzzle?.checkForSuccess(value: true)
        }
    }
    
    func batteryLevelDidChange(_ notification: NSNotification){
        // The battery's level did change (98%, 99%, ...)
        
        if UIDevice.current.batteryLevel <= 0.20 {
            //red
            let redPuzzle = batteryVM.puzzles.filter{$0.puzzleId == .redBattery}.first
            redPuzzle?.checkForSuccess(value: true)
        }
    }
    
    func willResignActive(_ notification: NSNotification) {
      
        if UIDevice.current.batteryLevel > 0.20 &&
            UIDevice.current.batteryState != .charging &&
            ProcessInfo.processInfo.isLowPowerModeEnabled == false
            {
            //white
            let whitePuzzle = batteryVM.puzzles.filter{$0.puzzleId == .whiteBattery}.first
            whitePuzzle?.checkForSuccess(value: true)
        }
    }
    
    func powerStateChanged(_ notification: NSNotification) {
        
        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            //yellow
            let yellowPuzzle = batteryVM.puzzles.filter{$0.puzzleId == .yellowBattery}.first
            yellowPuzzle?.checkForSuccess(value: true)
        }
    }
}
