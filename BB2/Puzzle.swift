import Foundation

protocol Puzzle {
    var puzzleId:PuzzleId {get}
    var isSolved:Bool {get}
    func checkForSuccess(value:Any?)
}
