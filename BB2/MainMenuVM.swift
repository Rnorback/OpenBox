//
//  MainMenuVM.swift
//  BB2
//
//  Created by Rob Norback on 2/15/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

class MainMenuVM {
    private(set) var menuItems:[MenuItem] = []
    
    init() {
        addWaitMenuItem()
        addFableMenuItem()
        addLowPowerMenuItem()
    }
    
    func addWaitMenuItem() {
        let color = Colors.Wait.light
        
        let oneSecond = LightVM(
            color: color,
            center: GridPosition(x: 5, y: 13).center,
            puzzleId: .waitOneSecond
        )
        
        let oneMinute = LightVM(
            color: color,
            center: GridPosition(x: 5, y: 12).center,
            puzzleId: .waitOneMinute
        )
        
        let oneHour = LightVM(
            color: color,
            center: GridPosition(x: 5, y: 11).center,
            puzzleId: .waitOneHour
        )
        
        let oneDay = LightVM(
            color: color,
            center: GridPosition(x: 5, y: 10).center,
            puzzleId: .waitOneDay
        )
        
        let waitMenuItem = MenuItem(
            segueId: .wait,
            lightData: [oneSecond, oneMinute, oneHour, oneDay]
        )
        
        menuItems.append(waitMenuItem)
    }
    
    func addFableMenuItem() {
        let color = Colors.Fable.light
        
        let readFirstStanza = LightVM(
            color: color,
            center: GridPosition(x: 6, y: 10).center,
            puzzleId: .readFirstStanza
        )
        
        let readForward = LightVM(
            color: color,
            center: GridPosition(x: 6, y: 11).center,
            puzzleId: .readForward
        )
        
        let readBackward = LightVM(
            color: color,
            center: GridPosition(x: 7, y: 10).center,
            puzzleId: .readBackward
        )
        
        let readRefrainBackward = LightVM(
            color: color,
            center: GridPosition(x: 7, y: 11).center,
            puzzleId: .readLastStanzaBackward
        )
        
        let readingMenuItem = MenuItem(
            segueId: .fable,
            lightData: [readFirstStanza, readForward, readBackward, readRefrainBackward]
        )
        
        menuItems.append(readingMenuItem)
    }
    
    func addLowPowerMenuItem() {
        let color = Colors.LowPower.light
        
        let lowPower = LightVM(
            color: color,
            center: GridPosition(x: 6, y: 9).center,
            puzzleId: .lowPower
        )
        
        let lowPowerMenuItem = MenuItem(
            segueId: .lowPower,
            lightData: [lowPower]
        )
        
        menuItems.append(lowPowerMenuItem)
    }
    
}
