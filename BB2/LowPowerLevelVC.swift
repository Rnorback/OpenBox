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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Menu.bg
        
        layoutLights()
        layoutBattery()
        
        NotificationCenter.default.addObserver(self, selector: #selector(powerStateChanged), name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    }
    
    deinit {
        print("deinit")
        NotificationCenter.default.removeObserver(self, name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    }
    
    func layoutBattery() {
        let batteryImageView:UIImageView = UIImageView(image: #imageLiteral(resourceName: "low-power-battery"))

        batteryImageView.center = CGPoint(
            x: view.frame.width/2,
            y: view.frame.height/2 + batteryLightDistance/2
        )
        batteryImageView.layer.zPosition = -1
        view.addSubview(batteryImageView)
    }
    
    func layoutLights() {
        for lightVM in lowPowerVM.lightData {
            let light = LightButton(lightVM: lightVM)
            light.center = CGPoint(
                x: view.frame.width/2,
                y: view.frame.height/2 - batteryLightDistance/2
            )
            view.addSubview(light)
        }
    }
    
    func powerStateChanged(_ notification: Notification) {
        for puzzle in lowPowerVM.puzzles {
            puzzle.checkForSuccess(value: 0)
        }
    }
}
