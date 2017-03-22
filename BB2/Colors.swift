//
//  Colors.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

struct Colors {
    
    struct FallingBlock {
        static var light = UIColor.yellow
        static var block = UIColor.yellow
    }
    
    struct Battery {
        static var light = UIColor(red: 0.169, green: 0.424, blue: 0.624, alpha: 1.00)
        static var yellow = UIColor(red: 0.996, green: 0.796, blue: 0.184, alpha: 1.00)
        static var red = UIColor(red: 1.000, green: 0.200, blue: 0.169, alpha: 1.00)
        static var green = UIColor(red: 0.263, green: 0.827, blue: 0.349, alpha: 1.00)
        static var white = UIColor.white
    }
    
    static var heartRate = UIColor(red: 0.800, green: 0.267, blue: 0.267, alpha: 1.00)
    static var coolPlaces = UIColor(red: 0.490, green: 0.827, blue: 0.976, alpha: 1.00)
    
    struct Wait {
        static var bg = UIColor(red: 0.596, green: 0.933, blue: 0.525, alpha: 1.00)
        static var light = UIColor(red: 0.325, green: 0.812, blue: 0.286, alpha: 1.00)
    }
    
    struct Fable {
        static var light = UIColor(red: 0.910, green: 0.188, blue: 0.188, alpha: 1.00)
    }
    
    
    
    struct Menu {
        static var bgDot = UIColor.lightGray
        static var bg = UIColor.black
    }
}
