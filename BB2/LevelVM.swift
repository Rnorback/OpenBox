//
//  LevelVM.swift
//  BB2
//
//  Created by Rob Norback on 2/15/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

protocol LevelVM {
    var lightData:[LightVM] {get}
    var puzzles:[Puzzle] {get}
    
    func prepLightData()
}
