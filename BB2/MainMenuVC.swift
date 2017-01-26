//
//  MainMenuVC.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {
    
    let puzzles:[Puzzle] = [
        ReadingPuzzle(),
        HeartRatePuzzle(),
        CoolPlacesPuzzle()
    ]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawScrollView()
        placeDots()
        placeLightButtons()
    }
}

//MARK: - View Loading Helpers
extension MainMenuVC {

    func placeLightButtons() {
        for puzzle in puzzles {
            for light in puzzle.lightGroup.lights {
                light.onClick = { [weak self] in
                    let identifier = SegueIdentifier(puzzleId: light.puzzleId)
                    self?.performSegue(withIdentifier: identifier, sender: self)
                }
                scrollView.addSubview(light)
            }
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
                let dot = Dot(position:
                    CGPoint(
                        x: x * betweenDots + betweenDots/2,
                        y: y * betweenDots + betweenDots/2
                    )
                )
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
        
        init(puzzleId:PuzzleId) {
            switch puzzleId {
            case .reading:
                self = .showReading
            case .heartRate:
                self = .showHeartRate
            case .coolPlaces:
                self = .showCoolPlaces
            }
        }
    }
}



