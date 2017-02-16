//
//  MainMenuVC.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    var dotsAcross:Int {
        return Values.dotsAcross
    }
    var dotsDown:Int {
        return Values.dotsDown
    }
    var dotsBuffer:Int {
        return Values.dotsBuffer
    }
    var betweenDots:Int {
        return Values.betweenDots
    }
    
    var totalDotsAcross:Int {
        return dotsAcross + 2 * dotsBuffer
    }
    
    var totalDotsDown:Int {
        return dotsDown + 2 * dotsBuffer
    }
    
    ///Size of the scrollable content (including pullable edges)
    var contentViewSize:CGSize {
        let width = totalDotsAcross * betweenDots
        let height = totalDotsDown * betweenDots
        return CGSize(width: width, height: height)
    }
    
    ///Size of the pullable edges
    var contentViewBuffer:CGFloat {
        return CGFloat(dotsBuffer * betweenDots)
    }
    
    ///The pullable edges around the scrollable area
    var contentInset:UIEdgeInsets {
        return UIEdgeInsets(
            top:    -contentViewBuffer,
            left:   -contentViewBuffer,
            bottom: -contentViewBuffer,
            right:  -contentViewBuffer
        )
    }
    
    var playableOffsetX:CGFloat {
        return contentViewBuffer + CGFloat(Values.dotsOffsetAcross * betweenDots)
    }
    
    var playableOffsetY:CGFloat {
        return contentViewBuffer + CGFloat(Values.dotsOffsetDown * betweenDots)
    }
    
    ///Where the scrollable area is focused at first
    var contentOffset:CGPoint {
        return CGPoint(
            x: playableOffsetX,
            y: playableOffsetY
        )
    }
    
    var scrollView:UIScrollView!
    var lightGroups:[LightGroup] = []
    var mainMenuVM:MainMenuVM = MainMenuVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let gridPos = GridPosition(x: 7, y: 7)
//        let lightButton = LightButton(gridPos: gridPos, color: UIColor.black)
//        lightButton.center = CGPoint(x: 100, y: 100)
//        view.addSubview(lightButton)
//        lightButton.addTarget(self, action: #selector(light(lightButton:)), for: .touchUpInside)
//        
        
        drawScrollView()
        placeDots()
        createLightGroupsAndPlaceLights()
    }
    
    func light(lightButton:LightButton) {
        lightButton.isLit = lightButton.isLit ? true : false
    }
}

//MARK: - View Loading Helpers
extension MainMenuVC {

    func createLightGroupsAndPlaceLights() {
        
        // for each menu item
        for menuItem in mainMenuVM.menuItems {
            //create a light for each lightVM and add it to the screen
            var lights:[LightButton] = []
            for lightVM in menuItem.lightData {
                
                let light = LightButton(lightVM: lightVM)
                light.onClick = { [weak self] in
                    let identifier = SegueIdentifier(segueId: menuItem.segueId)
                    self?.performSegue(withIdentifier: identifier, sender: self)
                }
                
                scrollView.addSubview(light)
                lights.append(light)
                
            }
            
            //create a light group add it to the lightGroups array
            let lightGroup:LightGroup = LightGroup(lightButtons: lights)
            lightGroups.append(lightGroup)
        }
    }
    
    func drawScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = contentViewSize
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.contentOffset = contentOffset
        scrollView.contentInset = contentInset
        view.addSubview(scrollView)
    }
    
    func placeDots() {
        for x in 0...totalDotsAcross {
            for y in 0...totalDotsDown {
                let position = CGPoint(x: x * betweenDots + betweenDots/2, y: y * betweenDots + betweenDots/2)
                let dot = Dot(position: position, color: Colors.bgDot)
                scrollView.layer.addSublayer(dot)
            }
        }
    }
}

extension MainMenuVC: SegueHandlerType {
    
    enum SegueIdentifier : String {
        case showReading
        case showHeartRate
        case showCoolPlaces
        case showWait
        
        init(segueId:SegueId) {
            switch segueId {
            case .reading:
                self = .showReading
            case .heartRate:
                self = .showHeartRate
            case .coolPlaces:
                self = .showCoolPlaces
            case .wait:
                self = .showWait
            }
        }
    }
}



