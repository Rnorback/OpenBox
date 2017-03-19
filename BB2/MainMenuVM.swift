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
        addBatteryMenuItem()
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
    
    func addBatteryMenuItem() {
        let color = Colors.Battery.light
        
        let yellowBattery = LightVM(
            color: color,
            center: GridPosition(x: 6, y: 9).center,
            puzzleId: .yellowBattery
        )
        
        let redBattery = LightVM(
            color: color,
            center: GridPosition(x: 7, y: 9).center,
            puzzleId: .redBattery
        )
        
        let greenBattery = LightVM(
            color: color,
            center: GridPosition(x: 8, y: 9).center,
            puzzleId: .greenBattery
        )
        
        let whiteBattery = LightVM(
            color: color,
            center: GridPosition(x: 8, y: 10).center,
            puzzleId: .whiteBattery
        )
        
        let lowPowerMenuItem = MenuItem(
            segueId: .battery,
            lightData: [yellowBattery, redBattery, greenBattery, whiteBattery]
        )
        
        menuItems.append(lowPowerMenuItem)
    }
    
}
