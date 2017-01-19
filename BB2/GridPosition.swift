//
//  Position.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

struct GridPosition {
    var x:Int
    var y:Int
    
    ///Center based on grid position
    var center:CGPoint {
        let buffer = Values.dotsBuffer * Values.betweenDots + Values.betweenDots/2
        let xPos = x * Values.betweenDots + buffer
        let yPos = y * Values.betweenDots + buffer
        return CGPoint(x: xPos, y: yPos)
    }
}
