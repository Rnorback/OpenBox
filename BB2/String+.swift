//
//  String+.swift
//  BB2
//
//  Created by Rob Norback on 1/26/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

extension String {
    
    func width(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func height(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
    
}
