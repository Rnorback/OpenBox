//
//  Light.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class Light: UIView {
    
    private let signal:String
    
    init(gridPos:GridPosition, color:UIColor, signal:String) {
        self.signal = signal
        
        let width = CGFloat(Values.lightWidth)
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        
        self.center = gridPos.center
        backgroundColor = color
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //fire off starting signal
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //fire off ending signal
    }
    
    //listen for starting signal
    //then animate the view to get smaller (just once)
    //listen for ending signal
    //then animate the view to get bigger
    
}
