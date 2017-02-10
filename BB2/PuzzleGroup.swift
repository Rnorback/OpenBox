//
//  Puzzle.swift
//  BB2
//
//  Created by Rob Norback on 1/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

protocol PuzzleGroup {
    var lightGroup:LightGroup {get}
    var puzzleId:PuzzleId {get}
}
