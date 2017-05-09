//
//  TodayViewController.swift
//  OpenBoxExtension
//
//  Created by Rob Norback on 5/8/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreMotion
import AVFoundation

class TodayViewController: UIViewController {
    
    var clink: AVAudioPlayer?
    var shatter: AVAudioPlayer?
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    let motionManager:CMMotionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the sound
        shatter = setupAudioPlayer(withFile: "shatter", type: "wav")
        clink = setupAudioPlayer(withFile: "clink", type: "wav")
        
        //allows for larger display
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        view.backgroundColor = .black
        view.alpha = 0.8
        bouncingLightButton()
    
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(TodayViewController.tapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupAudioPlayer(withFile file: String, type: String) -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: file, ofType: type)
        let url = NSURL.fileURL(withPath: path!)
        return try? AVAudioPlayer(contentsOf: url)
    }
    
    
    func bouncingLightButton() {
        let compactSize = (extensionContext?.widgetMaximumSize(for: .compact))!
        let center = CGPoint(x: compactSize.width/2, y: compactSize.height/2)
        let lightVM = LightVM(
            color: .purple,
            center: center,
            puzzleId: .todayExtension
        )
        let lightButton = LightButton(lightVM: lightVM)
        view.addSubview(lightButton)
        
        let lightVM1 = LightVM(
            color: .white,
            center: center,
            puzzleId: .todayExtension
        )
        let lightButton1 = LightButton(lightVM: lightVM1)
        view.addSubview(lightButton1)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        collision = UICollisionBehavior(items: [lightButton])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        //        anchorView = UIView(frame: CGRect(x: view.center.x, y: view.center.y, width: 20, height: 20))
        //        anchorView.backgroundColor = UIColor.red
        //        view.addSubview(anchorView)
        //
        //        attachment = UIAttachmentBehavior(item: squareView, attachedToAnchor: CGPoint(x: anchorView.center.x, y: anchorView.center.y))
        //
        //
        //        animator.addBehavior(attachment)
        
        gravity = UIGravityBehavior(items: [lightButton])
        
        gravity.action = {
            let center = CGPoint(x: compactSize.width/2, y: compactSize.height/2)
            print("Widget center", center)
            print("Light button center", lightButton.center)
            let dif:CGFloat = 2
            if (lightButton.center.x <= center.x + dif &&
                lightButton.center.x >= center.x - dif) &&
                (lightButton.center.y <= center.y + dif &&
                lightButton.center.y >= center.y - dif)
                {
                self.clink?.play()
                print("IT WORKED", lightButton.center)
            }
        }
        setupAccelerometer()
        animator.addBehavior(gravity)
        
        let itemBehavior = UIDynamicItemBehavior(items: [lightButton])
        itemBehavior.elasticity = 0.2
        itemBehavior.friction = 0.01
        itemBehavior.angularResistance = 0.01
        animator.addBehavior(itemBehavior)
    }
    
    func setupAccelerometer() {
        motionManager.accelerometerUpdateInterval = 0.4
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: OperationQueue(), withHandler: {[unowned self] (data, error) in
                if error != nil {
                    print("\(type(of:self)), Accelerometer Error")
                    return
                }
                let magnitude:Double = 1.0
                let xAccel = CGFloat(magnitude * data!.acceleration.x)
                let yAccel = CGFloat(-magnitude * data!.acceleration.y)
                DispatchQueue.main.async {
                    self.gravity.gravityDirection = CGVector(dx: xAccel, dy: yAccel)
                }
            })
        }
    }

    
    func tapped() {
        print("Background tapped")
        let url = URL(string: "openbox://")!
        extensionContext?.open(url , completionHandler: nil)
    }
    
    func injected() {
        viewDidLoad()
    }
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 200)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
