//
//  Values.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

struct Values {
    ///Total dots across the normal payable area
    static let dotsAcross:Int = 14
    static let dotsDown:Int = 22
    
    ///The offset from the top left of the playable area
    static let dotsOffsetAcross:Int = 3
    static let dotsOffsetDown:Int = 5
    
    ///Dot distance from edge
    static let dotsBuffer:Int = 8
    
    ///Distance between dots
    static let betweenDots:Int = 50
    
    ///Size of the lights
    static var lightWidth:Int = 43
}
