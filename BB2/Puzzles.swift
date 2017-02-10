//
//  Puzzles.swift
//  BB2
//
//  Created by Rob Norback on 2/7/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import Foundation

struct Puzzles {
    static let wait = WaitPuzzle()
    static let reading = ReadingPuzzle()
    static let heart = HeartRatePuzzle()
    static let places = CoolPlacesPuzzle()
    
    static let all:[PuzzleGroup] = [wait, reading, heart, places]
}
