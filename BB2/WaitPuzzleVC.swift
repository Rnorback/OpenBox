//
//  WaitPuzzleVC.swift
//  BB2
//
//  Created by Rob Norback on 2/7/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class WaitPuzzleVC: UIViewController {
    
    weak var waitPuzzle:WaitPuzzle!
    var timerView:UIView = UIView()
    var timer:Timer = Timer()
    var lights:[LightButton] = []
    
    var numLights:Int {
        return waitPuzzle.lightGroup.lights.count
    }
    var buttonSepDis:CGFloat {
        return view.frame.height/CGFloat(numLights + 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.bg
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        for (index, light) in waitPuzzle.lightGroup.lights.enumerated() {
            let lightCopy:LightButton = light.copy() as! LightButton
            let buttonHeight = buttonSepDis * CGFloat(index + 1)
            lightCopy.center = CGPoint(
                x: view.frame.width/2,
                y: buttonHeight
            )
            lights.append(lightCopy)
            view.addSubview(lightCopy)
        }
    
        zeroTimerFrame()
        timerView.backgroundColor = Colors.wait
        timerView.layer.zPosition = -1
        view.addSubview(timerView)
        
        disableScreenSleep()
        deviceOrientationDidChange()
    }

    deinit {
        print("deinit")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        stopTimer()
        allowScreenSleep()
    }
    
    func deviceOrientationDidChange() {
        if UIDevice.current.orientation == .faceDown {
            startTimer()
        } else {
            stopTimer()
            zeroTimerFrame()
        }
    }
}

//MARK: - Timer
extension WaitPuzzleVC {
    func zeroTimerFrame() {
        let timerFrame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 0)
        UIView.animate(withDuration: 1) {
            self.timerView.frame = timerFrame
        }
    }
    
    func startTimer() {
        if timer.isValid {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func timerFired() {
        var increment:CGFloat = 0
        
        switch timerView.frame.height {
        case 0..<buttonSepDis:
            increment = buttonSepDis/60
        case buttonSepDis..<buttonSepDis*2:
            lights[numLights-1].lightState = .lit
            waitPuzzle.lightGroup.lights[numLights-1].lightState = .lit
            increment = buttonSepDis/(60*60)
        case buttonSepDis*2..<buttonSepDis*3:
            lights[numLights-2].lightState = .lit
            waitPuzzle.lightGroup.lights[numLights-2].lightState = .lit
            increment = buttonSepDis/(60*60*24)
        case buttonSepDis*3..<buttonSepDis*4:
            increment = buttonSepDis/60
        case buttonSepDis*4:
            lights[numLights-3].lightState = .lit
            waitPuzzle.lightGroup.lights[numLights-3].lightState = .lit
            increment = 0
            stopTimer()
        default:
            break
        }
        
        self.timerView.frame = CGRect(
            x: 0,
            y: self.timerView.frame.origin.y - increment,
            width: self.timerView.frame.width,
            height: self.timerView.frame.height + increment
        )
        
    }
}

//MARK: Screen Idle
extension WaitPuzzleVC {
    fileprivate func allowScreenSleep() {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    fileprivate func disableScreenSleep() {
        UIApplication.shared.isIdleTimerDisabled = true
    }
}
