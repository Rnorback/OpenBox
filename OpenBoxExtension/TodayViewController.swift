//
//  TodayViewController.swift
//  OpenBoxExtension
//
//  Created by Rob Norback on 5/8/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let lightVM = LightVM(
            color: .purple,
            center: CGPoint(x: 180, y: 55),
            puzzleId: .todayExtension
        )
        let lightButton = LightButton(lightVM: lightVM)
        view.addSubview(lightButton)
    }
    
    func injected() {
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
