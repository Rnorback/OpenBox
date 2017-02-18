//
//  Puzzle.swift
//  BB2
//
//  Created by Rob Norback on 2/10/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

protocol Puzzle {
    var puzzleId:PuzzleId {get}
    var isSolved:Bool {get}
    func checkForSuccess(value:Int?)
}
